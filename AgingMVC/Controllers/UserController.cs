using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace AgingMVC.Controllers
{
    public class UserController : Controller
    {
        //
        // GET: /User/

        public ActionResult Index()
        {
            var users = Membership.GetAllUsers().Cast<MembershipUser>().Select(m => m.UserName).ToList();
            ViewBag.Users = users;
            return View();
        }

        public ActionResult Edit(string userName)
        {
            MembershipUser user = Membership.GetUser(userName);
            return View(user);
        }
    }
}
