using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Profile;
using System.Web.Routing;
using System.Web.Security;
using AgingMVC.Models;
using RestSharp;

namespace AgingMVC.Controllers
{
    public class AccountController : Controller
    {
        //
        // GET: /Account/

        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /Account/LogOn

        public ActionResult LogOn()
        {
            return View();
        }

        //
        // POST: /Account/LogOn

        [HttpPost]
        public ActionResult LogOn(LogOnModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                if (Membership.ValidateUser(model.UserName, model.Password))
                {
                    FormsAuthentication.SetAuthCookie(model.UserName, model.RememberMe);
                    if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                        && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        return RedirectToAction("Index", "Home");
                    }
                }
                //else
                //{
                //    ModelState.AddModelError("", "The user name or password provided is incorrect.");
                //}
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/LogOff

        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();

            return RedirectToAction("Index", "Home");
        }

        //
        // GET: /Account/Register

        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register

        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                // Validate the group code

                // Attempt to register the user
                MembershipCreateStatus createStatus;
                Membership.CreateUser(model.UserName, model.Password, model.Email, model.SecurityQuestion, model.SecurityAnswer, true, null, out createStatus);

                ProfileBase profile = ProfileBase.Create(model.UserName);

                profile.SetPropertyValue("groupCode", model.GroupCode);
                profile.Save();

                if (createStatus == MembershipCreateStatus.Success)
                {
                    FormsAuthentication.SetAuthCookie(model.UserName, false /* createPersistentCookie */);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError("", ErrorCodeToString(createStatus));
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/ChangePassword

        //[Authorize]
        //public ActionResult ChangePassword()
        //{
        //    return View();
        //}

        //
        // POST: /Account/ChangePassword

        [Authorize]
        [HttpPost]
        public ActionResult ChangePassword(ChangePasswordModel model)
        {
            if (ModelState.IsValid)
            {
                // ChangePassword will throw an exception rather
                // than return false in certain failure scenarios.
                bool changePasswordSucceeded;
                try
                {
                    MembershipUser currentUser = Membership.GetUser(User.Identity.Name, true /* userIsOnline */);
                    changePasswordSucceeded = currentUser.ChangePassword(model.OldPassword, model.NewPassword);
                }
                catch (Exception)
                {
                    changePasswordSucceeded = false;
                }

                if (changePasswordSucceeded)
                {
                    return RedirectToAction("ChangePasswordSuccess");
                }
                else
                {
                    ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/ChangePasswordSuccess

        public ActionResult ChangePasswordSuccess()
        {
            return View();
        }

        public ActionResult ForgotPassword()
        {
            ForgotPasswordModel model = new ForgotPasswordModel();
            model.State = ForgotPasswordStates.EnterUserName.ToString();
            return View(model);
        }

        [HttpPost]
        public ActionResult ForgotPassword(ForgotPasswordModel model)
        {
            // lookup user
            MembershipUser user = Membership.GetUser(model.UserName);
            if (model.State == ForgotPasswordStates.EnterUserName.ToString()
                && !string.IsNullOrWhiteSpace(model.UserName)
                && user == null)
            {
                ModelState.AddModelError("", "User not found");
                model = new ForgotPasswordModel()
                {
                    State = ForgotPasswordStates.EnterUserName.ToString()
                };

                return View(model);
            }
            else if (model.State == ForgotPasswordStates.EnterUserName.ToString())
            {
                model = new ForgotPasswordModel()
                {
                    UserName = model.UserName,
                    SecurityQuestion = user.PasswordQuestion,
                    State = ForgotPasswordStates.EnterSecretAnswer.ToString()
                };
                model.State = ForgotPasswordStates.EnterSecretAnswer.ToString();
                return View(model);
            }
            else if (model.State == ForgotPasswordStates.EnterSecretAnswer.ToString())
            {
                string newPassword = "rolltide15";
                try
                {
                    var tempPassword = user.ResetPassword(model.SecurityAnswer);
                    user.ChangePassword(tempPassword, newPassword);

                    SendForgotPasswordEmail(user.Email, newPassword);
                    model = new ForgotPasswordModel()
                    {
                        State = ForgotPasswordStates.Finalize.ToString()
                    };
                }
                catch (MembershipPasswordException ex)
                {
                    model = new ForgotPasswordModel()
                    {
                        State = ForgotPasswordStates.EnterSecretAnswer.ToString(),
                        UserName = model.UserName,
                        SecurityQuestion = model.SecurityQuestion
                    };
                    ModelState.AddModelError("", "Invalid security answer.");
                }
                return View(model);
            }
            else
            {
                model = new ForgotPasswordModel()
                {
                    State = ForgotPasswordStates.EnterUserName.ToString()
                };
                return View(model);

            }

        }

        private void SendForgotPasswordEmail(string email, string newPassword)
        {
            string API_KEY = "key-3xyyhwdmmzl-2xv308v4-g-wxs-j63o4";
            string DOMAIN = "mail.agereadynow.com";

            RestClient client = new RestClient();
            client.BaseUrl = new Uri("https://api.mailgun.net/v2");
            client.Authenticator =
                    new HttpBasicAuthenticator("api", API_KEY);
            RestRequest request = new RestRequest();
            request.AddParameter("domain", DOMAIN, ParameterType.UrlSegment);
            request.Resource = DOMAIN + "/messages";
            request.AddParameter("from", "Excited User <YOU@YOUR_DOMAIN_NAME>");
            request.AddParameter("to", email);
            request.AddParameter("subject", "Hello");
            request.AddParameter("text", "Testing some Mailgun awesomness!");
            request.Method = Method.POST;
            var response = client.Execute(request);

        }


        #region Status Codes

        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://go.microsoft.com/fwlink/?LinkID=177550 for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "User name already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A user name for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }

        #endregion
    }
}
