using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AgingMVC.Controllers
{
    public class HomeController : Controller
    {
        //[CacheControl(HttpCacheability.NoCache)]
        public ActionResult Index()
        {
            if (Request.IsAuthenticated)
            {
                AgingMVC.Models.User user = null;
                using (AgingMVC.Models.AgingEntities context = new Models.AgingEntities())
                {
                    user = context.User.Include("ParentSummaries").First(u => u.UserName == this.User.Identity.Name);
                    //user.Parents.Load();


                    // Do I need to do the reselect?  Aren't I just using the naked values?  Trims up what is in the JSON...
                    var parentSummariesQuery = from pi in user.ParentSummaries
                                               orderby pi.FirstName
                                               select new
                                               {
                                                   //ParentId = pi.ParentID,
                                                   Name = pi.FirstName,

                                                   pi.MedicalAssessmentCompleted,
                                                   pi.MedicalTaskCompleted,
                                                   pi.MedicalTotal,

                                                   pi.LegalAssessmentCompleted,
                                                   pi.LegalTaskCompleted,
                                                   pi.LegalTotal,

                                                   pi.SocialAssessmentCompleted,
                                                   pi.SocialTaskCompleted,
                                                   pi.SocialTotal,

                                                   pi.EmotionalAssessmentCompleted,
                                                   pi.EmotionalTaskCompleted,
                                                   pi.EmotionalTotal,

                                                   pi.Completed,
                                                   pi.Total

                                               };


                    var parentSummariesDict = parentSummariesQuery.ToDictionary(k => k.Name, v => v);


                    ViewBag.FirstParent = parentSummariesDict.Keys.FirstOrDefault();
                    ViewBag.CanAddParent = (parentSummariesDict.Count < 4);
                    string parentInfo = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(parentSummariesDict);
                    ViewBag.ParentData = parentInfo;
                }

                if (Request.QueryString["old"] != null)
                    return View("UserIndex", user);

                return View("UserIndex2", user);
            }

            return View("Index");
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult AboutUs()
        {
            return View();
        }

        public ActionResult ContactUs()
        {
            return View();
        }

        public ActionResult Help()
        {
            return View("Help");
        }

        //private string StatusString(int )
    }
}
