<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<List<AgingMVC.Models.State>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Task Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1>
            Resources to help you complete this task</h1>
    </div>
    <p>
        <a href="/Resources/<%:ViewBag.ParentName %>/<%:ViewBag.Domain %>" id="resourcelink">
            << Back to list of important
            <%:ViewBag.Domain %>
            tasks</a></p>
    <br />
    <h2 style="color: #3C7491; border: 1px solid #CCCCCC; font-family: trebuchet ms;
        font-weight: 100; letter-spacing: 1px; padding: 10px; text-transform: uppercase;">
        Task :
        <%: ViewBag.Task.ShortText %></h2>
    <div style="background: none repeat scroll 0 0 #F5F5F5; border-radius: 10px 10px 10px 10px;
        float: right; padding: 20px; width: 400px;">
        <div id="resourceheader">
            <b>
                <% if (ViewBag.IsSelf)
                       Response.Write(ViewBag.Task.PromptTextSelf);
                   else
                       Response.Write(ViewBag.Task.PromptText);
                %>
            </b>
        </div>
        <%if (ViewBag.IsSelf)
              Response.Write(ViewBag.Task.AssessmentTextSelf);
          else
              Response.Write(ViewBag.Task.AssessmentText);
        %>
    </div>
    <div>
        <h3>
            Select National or State Resources</h3>
        <select id="state" style="float: left; margin-bottom: 30px; padding-top: 0px; width: 450px;">
            <option style="cursor: pointer;">Select</option>
            <%foreach (var s in Model)
              {%>
            <option style="cursor: pointer;" class="state" value="<%:s.StateCode %>">
                <%: s.StateName %></option>
            <%} %>
        </select>
        <div style="width: 450px; padding-top: 20px;" class="task-box">
        </div>
    </div>
    <div style="clear: both;">
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {

            $("#state").change(
            function () {
                var statecode = $(this).val(); // $(this).attr("statecode");
                SetState(statecode);
            });

            $("#state").val('<%: ViewBag.State %>');
            SetState('<%: ViewBag.State %>');
        });

        function SetResources(data) {
            var html = "";
            for (var i = 0; i < data.length; i++) {
                if (html != "") html += "<hr />";

                html += "<b><a href=\"" + data[i].URL + "\">" + data[i].Name + "</a></b><br />";
                if (data[i].Description)
                    html += data[i].Description;
            }
            $(".task-box").html(html);
        }

        function SetState(statecode) {
            $.get('/Resources/Task/' + statecode + '/<%: ViewBag.Task.TaskId %>', SetResources);
        }


    </script>
</asp:Content>
