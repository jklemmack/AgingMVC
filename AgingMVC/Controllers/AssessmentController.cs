using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AgingMVC.Models;

namespace AgingMVC.Controllers
{
    public class AssessmentController : Controller
    {
        static Dictionary<int, List<PageInfo>> _views;
        static Dictionary<string, int> _domains;


        //Initialize the context on every page.  I'm sure this is bad form for some reason.
        private AgingEntities db = new AgingEntities();


        enum PageFlags
        {
            FirstPage,
            LastPage
        }

        struct PageInfo
        {
            public int ObjectiveId;
            public int Order;
            public string View;
            public PageFlags Flags;
        }

        static AssessmentController()
        {
            _views = new Dictionary<int, List<PageInfo>>();

            #region Medical
            List<PageInfo> medical = new List<PageInfo>();
            medical.Add(new PageInfo() { Order = 0, ObjectiveId = 1, View = "AssessmentIntro2", Flags = PageFlags.FirstPage });
            medical.Add(new PageInfo() { Order = 1, ObjectiveId = 1, View = "ObjectiveIntro" });
            medical.Add(new PageInfo() { Order = 2, ObjectiveId = 1, View = "Assessment" });
            medical.Add(new PageInfo() { Order = 3, ObjectiveId = 2, View = "ObjectiveIntro" });
            medical.Add(new PageInfo() { Order = 4, ObjectiveId = 2, View = "Assessment" });
            medical.Add(new PageInfo() { Order = 5, ObjectiveId = 3, View = "ObjectiveIntro" });
            medical.Add(new PageInfo() { Order = 6, ObjectiveId = 3, View = "Assessment" });
            medical.Add(new PageInfo() { Order = 7, ObjectiveId = 3, View = "AssessmentEnd", Flags = PageFlags.LastPage });
            _views.Add(1, medical);
            #endregion

            #region Legal
            List<PageInfo> legal = new List<PageInfo>();
            legal.Add(new PageInfo() { Order = 0, ObjectiveId = 1, View = "AssessmentIntro2" });
            //legal.Add(new PageInfo() { Order = 1, ObjectiveId = 4, View = "ObjectiveIntro" });
            legal.Add(new PageInfo() { Order = 2, ObjectiveId = 4, View = "Assessment" });
            //legal.Add(new PageInfo() { Order = 3, ObjectiveId = 5, View = "ObjectiveIntro" });
            legal.Add(new PageInfo() { Order = 4, ObjectiveId = 5, View = "Assessment" });
            //legal.Add(new PageInfo() { Order = 5, ObjectiveId = 6, View = "ObjectiveIntro" });
            legal.Add(new PageInfo() { Order = 6, ObjectiveId = 6, View = "Assessment" });
            legal.Add(new PageInfo() { Order = 7, ObjectiveId = 1, View = "AssessmentEnd" });
            _views.Add(2, legal);
            #endregion

            #region Family
            List<PageInfo> family = new List<PageInfo>();
            family.Add(new PageInfo() { Order = 0, ObjectiveId = 1, View = "AssessmentIntro" });
            //family.Add(new PageInfo() { Order = 1, ObjectiveId = 7, View = "ObjectiveIntro" });
            family.Add(new PageInfo() { Order = 2, ObjectiveId = 7, View = "Assessment" });
            //family.Add(new PageInfo() { Order = 3, ObjectiveId = 8, View = "ObjectiveIntro" });
            //family.Add(new PageInfo() { Order = 4, ObjectiveId = 8, View = "Assessment" });
            //family.Add(new PageInfo() { Order = 5, ObjectiveId = 9, View = "ObjectiveIntro" });
            //family.Add(new PageInfo() { Order = 6, ObjectiveId = 9, View = "Assessment" });
            family.Add(new PageInfo() { Order = 7, ObjectiveId = 1, View = "AssessmentEnd" });
            _views.Add(3, family);
            #endregion

            #region Emotional
            List<PageInfo> emotional = new List<PageInfo>();
            emotional.Add(new PageInfo() { Order = 0, ObjectiveId = 1, View = "AssessmentIntro" });
            //emotional.Add(new PageInfo() { Order = 1, ObjectiveId = 10, View = "ObjectiveIntro" });
            emotional.Add(new PageInfo() { Order = 1, ObjectiveId = 10, View = "Assessment" });
            //emotional.Add(new PageInfo() { Order = 3, ObjectiveId = 11, View = "ObjectiveIntro" });
            emotional.Add(new PageInfo() { Order = 2, ObjectiveId = 11, View = "Assessment" });
            //emotional.Add(new PageInfo() { Order = 5, ObjectiveId = 12, View = "ObjectiveIntro" });
            emotional.Add(new PageInfo() { Order = 3, ObjectiveId = 12, View = "Assessment" });
            emotional.Add(new PageInfo() { Order = 4, ObjectiveId = 13, View = "Assessment" });
            emotional.Add(new PageInfo() { Order = 5, ObjectiveId = 14, View = "Assessment" });
            emotional.Add(new PageInfo() { Order = 6, ObjectiveId = 15, View = "Assessment" });
            emotional.Add(new PageInfo() { Order = 7, ObjectiveId = 16, View = "Assessment" });
            emotional.Add(new PageInfo() { Order = 8, ObjectiveId = 17, View = "Assessment" });
            emotional.Add(new PageInfo() { Order = 9, ObjectiveId = 1, View = "AssessmentEnd" });
            _views.Add(4, emotional);
            #endregion

            _domains = new Dictionary<string, int>();
            _domains.Add("Medical", 1);
            _domains.Add("Legal", 2);
            _domains.Add("Social", 3);
            _domains.Add("Emotional", 4);
        }

        [HttpGet]
        [Authorize]
        public ActionResult Index(string Domain, string Parent, int? Page)
        {
            int DomainId = -1;
            if (!_domains.TryGetValue(Domain, out DomainId))
            {
                //return error...
                throw new ArgumentOutOfRangeException("Unknown domain");
            }

            if (Page.HasValue == false)
                Page = 0;

            //load model
            PageInfo pageInfo = _views[DomainId][Page.Value];
            object model = null;

            switch (pageInfo.View)
            {
                case "AssessmentIntro":
                case "AssessmentIntro2":

                    Models.Domain domain = (from d in db.Domains.Include("Videos")
                                            where d.DomainId == DomainId
                                            select d).Single<Models.Domain>();

                    foreach (Video v in domain.Videos)
                    {
                        if (v.ThumbImageURL == null)
                            v.ThumbImageURL = "/Content/Images/videothumbs/novideo.png";
                    }

                    var videos = domain.Videos.Select((v, index) => new VideoInfo()
                    {
                        Index = index,
                        VideoID = v.VideoID,
                        Copyright = v.Copyright,
                        Description = v.Description,
                        ShortText = v.ShortText,
                        ThumbImageURL = v.ThumbImageURL,
                        Type = v.Type,
                        URL = v.URL
                    }).ToDictionary(k => k.Index, v => v);

                    using (System.IO.TextWriter tw = new System.IO.StringWriter())
                    {
                        new Newtonsoft.Json.JsonSerializer().Serialize(tw, videos);
                        ViewBag.VideoDescriptions = tw.ToString();
                    }
                    ViewBag.Videos = videos.Select(kvp => kvp.Value);

                    model = domain;
                    ViewBag.DomainName = domain.Name;

                    break;

                case "Assessment":

                    Models.Objective objective = (from o in db.Objectives
                                                  where o.ObjectiveId == pageInfo.ObjectiveId
                                                  && o.DomainId == DomainId
                                                  select o).Single<Models.Objective>();

                    ViewBag.DomainName = objective.Domain.Name;
                    Guid userId = db.User.Include("Parents").First(u => u.UserName == this.User.Identity.Name).UserId;
                    Guid parentId = db.Parents.First(p => p.UserID == userId
                        && p.FirstName.Equals(Parent, StringComparison.InvariantCultureIgnoreCase)).ParentID;

                    model = db.GetAssessment(parentId, userId, pageInfo.ObjectiveId).ToList();

                    ViewBag.IsSelf = (string.Compare(Parent, "Myself") == 0);
                    var tasks = ((IEnumerable<GetAssessment_Result>)model).Select(t => new TaskInfo()
                    {
                        TaskId = t.TaskId,
                        ShortText = t.ShortText,
                        PromptText = (ViewBag.IsSelf) ? t.PromptTextSelf : t.PromptText,
                        Description = ((ViewBag.IsSelf) ? t.AssessmentTextSelf : t.AssessmentText).Replace("\n", "<p />")
                    }).ToDictionary(k => k.TaskId, k => k);

                    using (System.IO.TextWriter tw = new System.IO.StringWriter())
                    {
                        new Newtonsoft.Json.JsonSerializer().Serialize(tw, tasks);
                        ViewBag.TaskDescriptions = tw.ToString();
                    }

                    ViewBag.ObjectiveHeader = ObjectiveHeader(objective.ObjectiveOrder);
                    break;

                case "ObjectiveIntro":
                    Models.Objective objective2 = (from o in db.Objectives
                                                   where o.ObjectiveId == pageInfo.ObjectiveId
                                                   && o.DomainId == DomainId
                                                   select o).Single<Models.Objective>();


                    objective2.Tasks.Load();
                    ViewBag.VideoURL = string.Format("/Content/Articulate/{0}/Objective{1:00}/story.html", objective2.Domain.ShortName, objective2.ObjectiveOrder);
                    ViewBag.DomainName = objective2.Domain.Name;
                    ViewBag.ObjectiveHeader = ObjectiveHeader(objective2.ObjectiveOrder);
                    model = objective2;

                    break;

                default:
                    break;
            }

            ViewBag.Domain = Domain;
            ViewBag.Parent = Parent;
            ViewBag.Page = Page;
            return View(pageInfo.View, model);
        }

        [HttpPost]
        [Authorize]
        public ActionResult Index(string Domain, string Parent, int? Page, FormCollection formData)
        {
            int DomainId = -1;
            if (!_domains.TryGetValue(Domain, out DomainId))
            {
                //return error...
                throw new ArgumentOutOfRangeException("Unknown domain");
            }

            PageInfo pageInfo = _views[DomainId].Single(pi => pi.Order == Page.Value);

            Guid userId = db.User.First(u => u.UserName == this.User.Identity.Name).UserId;
            Guid parentId = db.Parents.First(p => p.UserID == userId
                && p.FirstName.Equals(Parent, StringComparison.InvariantCultureIgnoreCase)).ParentID;

            var tasks = (
            from t in db.Tasks
            join tsr in db.TaskSurveyResponses
            on new { TaskID = t.TaskId, ParentID = parentId, UserID = userId }
                equals new { tsr.TaskID, tsr.ParentID, tsr.UserID } into tsr_join
            from tsr in tsr_join.DefaultIfEmpty()
            where t.ObjectiveId == pageInfo.ObjectiveId
            select new { t.TaskId, tsr }).ToList();

            foreach (var t in tasks)
            {
                int taskId = t.TaskId;
                TaskSurveyResponse tsr = t.tsr ?? new TaskSurveyResponse() { UserID = userId, ParentID = parentId, TaskID = taskId };
                tsr.LastUpdated = DateTime.UtcNow;

                bool completed = (formData["TaskCompleted." + taskId.ToString()] == "Yes" ? true : false);
                int timeLine = 0;
                Int32.TryParse(formData["TaskTimeline." + taskId.ToString()], out timeLine);

                tsr.Completed = completed;
                tsr.Timeline = timeLine;

                if (tsr.EntityState == System.Data.EntityState.Detached)
                    db.AddToTaskSurveyResponses(tsr);

            }

            db.SaveChanges();

            System.Web.Routing.RouteValueDictionary dict = new System.Web.Routing.RouteValueDictionary();
            dict.Add("Domain", Domain);
            dict.Add("Page", Page.Value + 1);

            return this.RedirectToAction("Index", dict);
        }


        private string ObjectiveHeader(int sequence)
        {
            const string format = "{0} Objective";
            string display = "";
            switch (sequence)
            {
                case 1:
                    display = "First";
                    break;
                case 2:
                    display = "Second";
                    break;
                case 3:
                    display = "Third";
                    break;

            }
            return string.Format(format, display);
        }
    }
}
