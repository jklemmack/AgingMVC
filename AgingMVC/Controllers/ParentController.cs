using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AgingMVC.Models;

namespace AgingMVC.Controllers
{
    public class ParentController : Controller
    {
        private AgingEntities db = new AgingEntities();

        ////
        //// GET: /Parent/
        //public ViewResult Index()
        //{
        //    var parents = db.Parents.Include("State1").Include("aspnet_Users");
        //    return View(parents.ToList());
        //}


        //
        // GET: /Parent/Details/5
        //public ViewResult Details(Guid id)
        //{
        //    Parent parent = db.Parents.Single(p => p.UserID == id);
        //    return View(parent);
        //}


        //
        // GET: /Parent/Create
        public ActionResult Create()
        {
            ViewBag.State = new SelectList(db.States, "StateCode", "StateName");
            ViewBag.UserID = new SelectList(db.User, "UserId", "UserName");
            return View();
        }


        //
        // POST: /Parent/Create
        [HttpPost]
        public ActionResult Create(Parent parent)
        {
            if (ModelState.IsValid)
            {
                parent.ParentID = Guid.NewGuid();   //Shouldn't have to do this, but for some reason it wasn't working
                parent.UserID = db.User.First(u => u.UserName == this.User.Identity.Name).UserId;
                db.Parents.AddObject(parent);
                db.SaveChanges();
                return RedirectToAction("Index", "Home");
            }

            ViewBag.State = new SelectList(db.States, "StateCode", "StateName", parent.State);
            ViewBag.UserID = new SelectList(db.User, "UserId", "UserName", parent.UserID);
            return View(parent);
        }


        //
        // GET: /Parent/Edit/Bob
        public ActionResult Edit(string id)
        {
            User user = db.User.Include("Parents").Single(u => u.UserName == this.User.Identity.Name);
            Parent parent = user.Parents.Single(p => string.Compare(p.FirstName, id, true) == 0);

            ViewBag.State = new SelectList(db.States, "StateCode", "StateName", parent.State);
            ViewBag.UserID = new SelectList(db.User, "UserId", "UserName", parent.UserID);
            return View(parent);
        }


        //
        // POST: /Parent/Edit
        [HttpPost]
        public ActionResult Edit(Parent parent)
        {
            if (ModelState.IsValid)
            {
                db.Parents.Attach(parent);
                db.ObjectStateManager.ChangeObjectState(parent, EntityState.Modified);
                db.SaveChanges();
                return RedirectToAction("Index", "Home");
            }
            ViewBag.State = new SelectList(db.States, "StateCode", "StateName", parent.State);
            ViewBag.UserID = new SelectList(db.User, "UserId", "UserName", parent.UserID);
            return View(parent);
        }

        //
        // POST: /Parent/Delete/Bob
        [HttpPost]
        public ActionResult Delete(string id)
        {
            User user = db.User.Include("Parents").Single(u => u.UserName == this.User.Identity.Name);
            Parent parent = user.Parents.Single(p => string.Compare(p.FirstName, id, true) == 0);

            //Parent parent = db.Parents.Single(p => p.UserID == id);
            foreach (AgingMVC.Models.TaskSurveyResponse tsr in parent.TaskSurveyResponses.ToList())
                db.TaskSurveyResponses.DeleteObject(tsr);

            db.Parents.DeleteObject(parent);
            db.SaveChanges();

            return RedirectToAction("Index", "Home");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }


    }
}