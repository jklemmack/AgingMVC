using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AgingMVC.Controllers
{
    public class ResourceController : Controller
    {

        public ActionResult TasksByDomain(string Parent, string Domain)
        {
            using (AgingMVC.Models.AgingEntities context = new Models.AgingEntities())
            {
                AgingMVC.Models.Domain domain = context.Domains.SingleOrDefault(d => string.Compare(d.ShortName, Domain, true) == 0);

                if (domain == null)
                    throw new ArgumentException(string.Format("'{0}' is not a valid domain name", Domain), "Domain");


                Guid userId = context.User.Include("Parents").First(u => u.UserName == this.User.Identity.Name).UserId;
                Guid parentId = context.Parents.First(p => p.UserID == userId
                        && p.FirstName.Equals(Parent, StringComparison.InvariantCultureIgnoreCase)).ParentID;

                var model = (from t in context.Tasks
                             join tsr in context.TaskSurveyResponses on new { TaskID = t.TaskId } equals new { TaskID = tsr.TaskID }
                             where
                               tsr.Completed == false &&
                               tsr.ParentID == parentId &&
                               tsr.UserID == userId &&
                               t.DomainId == domain.DomainId
                             select t).Take(7);

                var tasks = (from m in model
                             select new { m.TaskId, m.PromptText, m.AssessmentText }).ToDictionary(k => k.TaskId.ToString(), v => v);
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
            using (AgingMVC.Models.AgingEntities context = new Models.AgingEntities())
            {
                Guid userId = context.User.Include("Parents").First(u => u.UserName == this.User.Identity.Name).UserId;

                Models.Parent parent = context.Parents.First(p => p.UserID == userId
                        && p.FirstName.Equals(Parent, StringComparison.InvariantCultureIgnoreCase));
                Guid parentId = parent.ParentID;
                ViewBag.ParentName = parent.FirstName;
                ViewBag.Domain = Domain;
                
                //Set the state
                if (parent.State != null)
                    ViewBag.State = parent.State;
                else
                    ViewBag.State = "US";


                //Current task
                AgingMVC.Models.Task task = context.Tasks.Single(t => t.TaskId == Task);
                ViewBag.Task = task;

                if (string.Compare(Parent, "myself", true) == 0)
                    ViewBag.IsSelf = true;
                else
                    ViewBag.IsSelf = false;

                var model = context.States.OrderBy(s => s.SortOrder);

                return View("TaskDetails", model.ToList());
            }
        }

        public JsonResult ResoucesForTaskAndState(int Task, string State)
        {
            using (AgingMVC.Models.AgingEntities context = new Models.AgingEntities())
            {
                var resources =
                    context.Task_Resources.Where(tr => (tr.Resource.ResourceState == State
                                                        && tr.TaskID == Task)
                        ).Select(tr => new { tr.Resource.Name, tr.Resource.Description, tr.Resource.URL })
                        .ToList();
                return Json(resources, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
