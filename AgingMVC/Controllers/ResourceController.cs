using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AgingMVC.Models;
using ClosedXML.Excel;

namespace AgingMVC.Controllers
{
    public class ResourceController : Controller
    {
        private AgingEntities db = new AgingEntities();

        public ActionResult TasksByDomain(string Parent, string Domain)
        {
            Domain domain = db.Domains.SingleOrDefault(d => string.Compare(d.ShortName, Domain, true) == 0);

            if (domain == null)
                throw new ArgumentException(string.Format("'{0}' is not a valid domain name", Domain), "Domain");

            Guid userId = db.User.Include("Parents").First(u => u.UserName == this.User.Identity.Name).UserId;

            Models.Parent parent = db.Parents.First(p => p.UserID == userId
                    && p.FirstName.Equals(Parent, StringComparison.InvariantCultureIgnoreCase));
            Guid parentId = parent.ParentID;


            var model = (from t in db.Tasks
                         join tsr in db.TaskSurveyResponses on new { TaskID = t.TaskId } equals new { TaskID = tsr.TaskID }
                         where
                           tsr.Completed == false &&
                           tsr.ParentID == parentId &&
                           tsr.UserID == userId &&
                           t.DomainId == domain.DomainId
                         select t).Take(7);

            bool isSelf = false;
            if (string.Compare(Parent, "myself", true) == 0)
                isSelf = true;
            ViewBag.IsSelf = isSelf;

            var tasks = (from m in model
                         select new
                         {
                             m.TaskId,
                             PromptText = (isSelf) ? m.PromptTextSelf : m.PromptText,
                             AssessmentText = (isSelf) ? m.AssessmentTextSelf : m.AssessmentText
                         }).ToDictionary(k => k.TaskId.ToString(), v => v);

            string taskInfo = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(tasks);

            ViewBag.TaskData = taskInfo;
            ViewBag.DomainShortName = domain.ShortName;
            ViewBag.DomainName = domain.Name;
            ViewBag.Parent = Parent;

            return View("TasksByDomain", model.ToList());
        }

        public ActionResult TaskDetails(string Parent, string Domain, int Task)
        {
            Guid userId = db.User.Include("Parents").First(u => u.UserName == this.User.Identity.Name).UserId;

            Models.Parent parent = db.Parents.First(p => p.UserID == userId
                    && p.FirstName.Equals(Parent, StringComparison.InvariantCultureIgnoreCase));
            Guid parentId = parent.ParentID;
            ViewBag.ParentName = parent.FirstName;
            ViewBag.Domain = Domain;

            bool isSelf = false;
            if (string.Compare(Parent, "myself", true) == 0)
                isSelf = true;
            ViewBag.IsSelf = isSelf;

            //Set the state
            if (parent.State != null)
                ViewBag.State = parent.State;
            else
                ViewBag.State = "US";


            //Current task
            Task task = db.Tasks.Single(t => t.TaskId == Task);
            ViewBag.Task = task;


            var model = db.States.OrderBy(s => s.SortOrder);
            return View("TaskDetails", model.ToList());
        }

        public JsonResult ResoucesForTaskAndState(int Task, string State)
        {
            var resources =
                db.Task_Resources.Where(tr => (tr.Resource.ResourceState == State
                                                    && tr.TaskID == Task)
                    ).Select(tr => new { tr.Resource.Name, tr.Resource.Description, tr.Resource.URL })
                    .ToList();
            return Json(resources, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Download()
        {
            // all tasks
            var tasks = db.Tasks.OrderBy(t => t.TaskOrder).OrderBy(t => t.Domain.DomainOrder)
                .OrderBy(t => t.TaskOrder)
                .OrderBy(t => t.Domain.DomainOrder)
                .Select(t => new { TaskId = t.TaskId, Domain = t.Domain.Name, Task = t.ShortText }).ToList();

            var resources = db.Resources.Include("Task_Resources.Task")
                .Select(r => new
                {
                    ResourceId = r.ResourceID,
                    Name = r.Name,
                    State = r.State.StateCode,
                    Description = r.Description,
                    URL = r.URL,
                    Tasks = r.Task_Resources.Select(tr => tr.Task).OrderBy(t => t.TaskId),
                    Active = r.Active
                }).ToList();

            XLWorkbook wb = new XLWorkbook();

            using (IXLWorksheet ws = wb.AddWorksheet("Resources"))
            {
                ws.Cell(2, 1).Value = "ResourceId";
                ws.Cell(2, 2).Value = "Name";
                ws.Cell(2, 3).Value = "State";
                ws.Cell(2, 4).Value = "Description";
                ws.Cell(2, 5).Value = "URL";
                ws.Cell(2, 6).Value = "Active";

                int firstTaskCol = 7;
                int column = firstTaskCol;
                foreach (var task in tasks)
                {
                    ws.Cell(2, column).Value = task.Task;
                    column++;
                }

                int row = 3;
                foreach (var resource in resources)
                {
                    column = firstTaskCol;
                    ws.Cell(row, 1).Value = resource.ResourceId;
                    ws.Cell(row, 2).Value = resource.Name;
                    ws.Cell(row, 3).Value = resource.State;
                    ws.Cell(row, 4).Value = resource.Description;
                    ws.Cell(row, 5).Value = resource.URL;
                    ws.Cell(row, 6).Value = (resource.Active) ? "Y" : "N";

                    foreach (var task in tasks)
                    {
                        if (resource.Tasks.Count(t => t.TaskId == task.TaskId) > 0)
                            ws.Cell(row, column).Value = "X";
                        column++;
                    }

                    row++;
                }

                var firstCell = ws.Cell(2, 1);
                var lastCell = ws.LastCellUsed();
                var range = ws.Range(firstCell, lastCell);

                range.CreateTable();
                ws.Columns(1, 1).Hide();
                ws.Range(ws.Cell(2, firstTaskCol), ws.Cell(2, firstTaskCol + tasks.Count())).Style
                    .Alignment.SetTextRotation(90)
                    .Alignment.SetVertical(XLAlignmentVerticalValues.Top);
                ws.Columns(2, firstTaskCol + tasks.Count()).AdjustToContents();
            }


            MemoryStream ms = new MemoryStream();
            wb.SaveAs(ms);
            ms.Position = 0;
            string fileName = "TasksAndResources.xlsx";
            return File(ms, @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml", fileName);

        }

        [HttpPost]
        public ActionResult Index(HttpPostedFileBase file)
        {
            using (XLWorkbook wb = new XLWorkbook(file.InputStream))
            {
                IXLWorksheet ws = wb.Worksheet("Resources");
                int headerRow = 2;
                int ID = 1;
                int Name = 2;
                int State = 3;
                int Description = 4;
                int URL = 5;
                int Active = 6;

                int firstTaskCol = 7;

                int lastCol = ws.LastColumnUsed().ColumnNumber();
                int lastRow = ws.LastRowUsed().RowNumber();
                var tasks = db.Tasks.ToList();
                var states = db.States.ToList();
                var resources = db.Resources.Include("Task_Resources").ToList();
                Dictionary<int, int> columnToTasks = new Dictionary<int, int>();

                // Get the tasks, by name in order.  Map column ID to TaskID
                for (int col = firstTaskCol; col <= lastCol; col++)
                {
                    string task = (string)ws.Cell(headerRow, col).Value;
                    Task objTask = tasks.SingleOrDefault(t => string.Compare(t.ShortText, task, true) == 0);
                    if (objTask == null)
                    {
                        throw new ArgumentException("The task '{0}' wasn't found.", task);
                    }

                    columnToTasks.Add(col, objTask.TaskId);
                }

                for (int row = 3; row <= lastRow; row++)
                {
                    Resource resource = null;
                    Guid resourceId;
                    // Guid exists
                    if (Guid.TryParse((string)ws.Cell(row, ID).Value, out resourceId))
                    {
                        resource = resources.FirstOrDefault(r => r.ResourceID == resourceId);
                    }
                    else
                    {
                        // no guid, lookup by Name?
                        string name = (string)ws.Cell(row, Name).Value;
                        resource = resources.FirstOrDefault(r => string.Compare(name, r.Name, true) == 0);
                        if (resource == null)
                        {
                            resource = new Resource();
                            resource.ResourceID = Guid.NewGuid();
                            resource.Task_Resources = new System.Data.Objects.DataClasses.EntityCollection<Task_Resources>();
                            db.Resources.AddObject(resource);
                        }
                    }

                    try
                    {
                        // set name, state, description, url
                        resource.Name = (string)ws.Cell(row, Name).Value;
                        resource.Description = (string)ws.Cell(row, Description).Value;
                        resource.URL = (string)ws.Cell(row, URL).Value;
                        resource.State = states.First(s => string.Compare(s.StateCode, (string)ws.Cell(row, State).Value) == 0);
                        string active = (string)ws.Cell(row, Active).Value;
                        if (!string.IsNullOrWhiteSpace(active) && string.Compare(active, "Y", true) == 0)
                            resource.Active = true;
                        else
                            resource.Active = false;

                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                    for (int col = firstTaskCol; col <= lastCol; col++)
                    {
                        string value = ws.Cell(row, col).Value.ToString();
                        int taskId = columnToTasks[col];
                        var tr = resource.Task_Resources.SingleOrDefault(x => x.TaskID == taskId);
                        if (string.IsNullOrWhiteSpace(value) && tr != null)
                        {
                            // If resource had this task, remove it
                            db.Task_Resources.DeleteObject(tr);
                        }
                        else if (!string.IsNullOrWhiteSpace(value) && tr == null)
                        {
                            // If resource doesn't have this task, add it
                            tr = new Task_Resources() { TaskID = taskId, Resource = resource };
                            db.Task_Resources.AddObject(tr);
                        }
                    }
                    db.SaveChanges();

                }

            }

            return RedirectToAction("Index");
        }

        //
        // GET: /Resource/
        public ViewResult Index()
        {
            var resources = db.Resources.Include("State");
            return View(resources.ToList());
        }


        //
        // GET: /Resource/Details/5
        public ViewResult Details(Guid id)
        {
            Resource resource = db.Resources.Single(r => r.ResourceID == id);
            return View(resource);
        }

        //
        // GET: /Resource/Create
        public ActionResult Create()
        {
            ViewBag.ResourceState = new SelectList(db.States, "StateCode", "StateName");
            return View();
        }

        //
        // POST: /Resource/Create
        [HttpPost]
        public ActionResult Create(Resource resource)
        {
            if (ModelState.IsValid)
            {
                resource.ResourceID = Guid.NewGuid();
                db.Resources.AddObject(resource);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ResourceState = new SelectList(db.States, "StateCode", "StateName", resource.ResourceState);
            return View(resource);
        }

        //
        // GET: /Resource/Edit/5
        public ActionResult Edit(Guid id)
        {
            Resource resource = db.Resources.Single(r => r.ResourceID == id);
            ViewBag.ResourceState = new SelectList(db.States, "StateCode", "StateName", resource.ResourceState);
            return View(resource);
        }

        //
        // POST: /Resource/Edit/5
        [HttpPost]
        public ActionResult Edit(Resource resource)
        {
            if (ModelState.IsValid)
            {
                db.Resources.Attach(resource);
                db.ObjectStateManager.ChangeObjectState(resource, EntityState.Modified);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ResourceState = new SelectList(db.States, "StateCode", "StateName", resource.ResourceState);
            return View(resource);
        }

        //
        // GET: /Resource/Delete/5
        public ActionResult Delete(Guid id)
        {
            Resource resource = db.Resources.Single(r => r.ResourceID == id);
            return View(resource);
        }

        //
        // POST: /Resource/Delete/5
        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(Guid id)
        {
            Resource resource = db.Resources.Single(r => r.ResourceID == id);
            db.Resources.DeleteObject(resource);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}
