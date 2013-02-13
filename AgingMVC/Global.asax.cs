using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace AgingMVC
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            /* Assessment */
            routes.MapRoute(
                "Assessment",
                "Assessment/{Domain}/{Parent}/{Page}",
                new { controller = "Assessment", action = "Index", Page = UrlParameter.Optional }
            );

            /* Resources */
            routes.MapRoute(
                "ResourcesForDomain",
                "Resources/{Parent}/{Domain}",
                new { controller = "Resource", action = "TasksByDomain", Domain = UrlParameter.Optional }
            );

            // JSON route
            routes.MapRoute(
                "ResourcesForTaskAndState",
                "Resources/Task/{State}/{Task}",
                new { controller = "Resource", action = "ResoucesForTaskAndState" }
            );

            routes.MapRoute(
                "Resources",
                "Resources/{Parent}/{Domain}/{Task}",
                new { controller = "Resource", action = "TaskDetails" }
            );

            /* Default route */
            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );


        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }
    }
}