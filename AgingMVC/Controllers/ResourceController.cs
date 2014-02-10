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

        public ActionResult TasksByDomain(string Parent, string Domain)
        {
            using (AgingEntities context = new AgingEntities())
            {
                Domain domain = context.Domains.SingleOrDefault(d => string.Compare(d.ShortName, Domain, true) == 0);

                if (domain == null)
                    throw new ArgumentException(string.Format("'{0}' is not a valid domain name", Domain), "Domain");

                Guid userId = context.User.Include("Parents").First(u => u.UserName == this.User.Identity.Name).UserId;

                Models.Parent parent = context.Parents.First(p => p.UserID == userId
                        && p.FirstName.Equals(Parent, StringComparison.InvariantCultureIgnoreCase));
                Guid parentId = parent.ParentID;


                var model = (from t in context.Tasks
                             join tsr in context.TaskSurveyResponses on new { TaskID = t.TaskId } equals new { TaskID = tsr.TaskID }
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
        }

        public ActionResult TaskDetails(string Parent, string Domain, int Task)
        {
            using (AgingEntities context = new AgingEntities())
            {
                Guid userId = context.User.Include("Parents").First(u => u.UserName == this.User.Identity.Name).UserId;

                Models.Parent parent = context.Parents.First(p => p.UserID == userId
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
                Task task = context.Tasks.Single(t => t.TaskId == Task);
                ViewBag.Task = task;


                var model = context.States.OrderBy(s => s.SortOrder);

                return View("TaskDetails", model.ToList());
            }
        }

        public JsonResult ResoucesForTaskAndState(int Task, string State)
        {
            using (AgingEntities context = new AgingEntities())
            {
                var resources =
                    context.Task_Resources.Where(tr => (tr.Resource.ResourceState == State
                                                        && tr.TaskID == Task)
                        ).Select(tr => new { tr.Resource.Name, tr.Resource.Description, tr.Resource.URL })
                        .ToList();
                return Json(resources, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult Index()
        {
            using (AgingEntities context = new AgingEntities())
            {
                var resources = context.Resources;

                var states = context.States.ToList();
                states.Add(new Models.State() { StateCode = null, SortOrder = -1, StateName = "[Show All]" });

                ViewBag.SelectedState = null;
                ViewBag.States = states.OrderBy(s => s.SortOrder).ToList();

                return View(resources.ToList());
            }
        }

        public ActionResult Edit(Guid id)
        {
            using (AgingEntities context = new AgingEntities())
            {
                var resource = context.Resources.SingleOrDefault(r => r.ResourceID == id);
                ViewBag.States = context.States.OrderBy(s => s.SortOrder).ToList();

                return View(resource);
            }
        }

        [HttpPost]
        public ActionResult Edit(Resource resource)
        {

            using (AgingEntities context = new AgingEntities())
            {
                if (ModelState.IsValid)
                {
                    context.Resources.Attach(resource);
                    context.ObjectStateManager.ChangeObjectState(resource, EntityState.Modified);
                    context.SaveChanges();
                    return RedirectToAction("Index");
                }

                return View();
            }
        }
    }
}
