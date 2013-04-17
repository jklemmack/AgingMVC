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
            //ViewBag.Message = "Welcome to Parent Care Readiness";

            if (Request.IsAuthenticated)
            {
                AgingMVC.Models.User user = null;
                using (AgingMVC.Models.AgingEntities context = new Models.AgingEntities())
                {
                    user = context.User.Include("ParentSummaries").First(u => u.UserName == this.User.Identity.Name);
                    //user.Parents.Load();

                    var parentSummariesQuery = from pi in user.ParentSummaries
                                               orderby pi.FirstName
                                               select new
                                               {
                                                   //ParentId = pi.ParentID,
                                                   Name = pi.FirstName,

                                                   pi.MedicalCompleted,
                                                   pi.MedicalTotal,
                                                   MedicalProgress = 100 * pi.MedicalCompleted / pi.MedicalTotal,
                                                   MedicalText = "",

                                                   pi.LegalCompleted,
                                                   pi.LegalTotal,
                                                   LegalProgress = 100 * pi.LegalCompleted / pi.LegalTotal,
                                                   LegalText = "",

                                                   pi.SocialCompleted,
                                                   pi.SocialTotal,
                                                   SocialProgress = 100 * pi.SocialCompleted / pi.SocialTotal,
                                                   SocialText = "",

                                                   pi.EmotionalCompleted,
                                                   pi.EmotionalTotal,
                                                   EmotionalProgress = 100 * pi.EmotionalCompleted / pi.EmotionalTotal,
                                                   EmotionalText = "",

                                               };

                    
                    var parentSummariesDict = parentSummariesQuery.ToDictionary(k => k.Name, v => v);


                    ViewBag.FirstParent = parentSummariesDict.Keys.FirstOrDefault();

                    string parentInfo = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(parentSummariesDict);
                    ViewBag.ParentData = parentInfo;
                }

                ViewBag.MedicalProgress = 37;
                ViewBag.LegalProgress = 80;
                ViewBag.SocialProgress = 0;
                ViewBag.EmotionalProgress = 100;


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
    }
}
