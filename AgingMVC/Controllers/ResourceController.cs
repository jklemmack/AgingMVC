using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AgingMVC.Models;

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
