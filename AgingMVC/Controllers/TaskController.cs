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
    [Authorize(Roles = "Admin")]
    public class TaskController : Controller
    {
        private AgingEntities db = new AgingEntities();

        //
        // GET: /Task/
        public ViewResult Index()
        {
            var tasks = db.Tasks.Include("Domain").Include("Objective");
            return View(tasks.ToList());
        }

        //
        // GET: /Task/Details/5

        public ViewResult Details(int id)
        {
            Task task = db.Tasks.Single(t => t.TaskId == id);
            return View(task);
        }

        //
        // GET: /Task/Create

        public ActionResult Create()
        {
            ViewBag.DomainId = new SelectList(db.Domains, "DomainId", "Name");
            ViewBag.ObjectiveId = new SelectList(db.Objectives, "ObjectiveId", "ObjectiveText");
            return View();
        }

        //
        // POST: /Task/Create

        [HttpPost]
        public ActionResult Create(Task task)
        {
            if (ModelState.IsValid)
            {
                db.Tasks.AddObject(task);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.DomainId = new SelectList(db.Domains, "DomainId", "Name", task.DomainId);
            ViewBag.ObjectiveId = new SelectList(db.Objectives, "ObjectiveId", "ObjectiveText", task.ObjectiveId);
            return View(task);
        }

        //
        // GET: /Task/Edit/5
        public ActionResult Edit(int id)
        {
            Task task = db.Tasks.Single(t => t.TaskId == id);
            ViewBag.DomainId = new SelectList(db.Domains, "DomainId", "Name", task.DomainId);
            ViewBag.ObjectiveId = new SelectList(db.Objectives, "ObjectiveId", "ObjectiveText", task.ObjectiveId);
            return View(task);
        }

        //
        // POST: /Task/Edit/5

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(Task task)
        {
            if (ModelState.IsValid)
            {
                db.Tasks.Attach(task);
                db.ObjectStateManager.ChangeObjectState(task, EntityState.Modified);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.DomainId = new SelectList(db.Domains, "DomainId", "Name", task.DomainId);
            ViewBag.ObjectiveId = new SelectList(db.Objectives, "ObjectiveId", "ObjectiveText", task.ObjectiveId);
            return View(task);
        }

        //
        // GET: /Task/Delete/5

        public ActionResult Delete(int id)
        {
            Task task = db.Tasks.Single(t => t.TaskId == id);
            return View(task);
        }

        //
        // POST: /Task/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            Task task = db.Tasks.Single(t => t.TaskId == id);
            db.Tasks.DeleteObject(task);
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