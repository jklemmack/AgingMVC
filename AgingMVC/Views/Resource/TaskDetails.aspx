<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<List<AgingMVC.Models.State>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Task Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p><a href="/Resources/<%:ViewBag.ParentName %>/<%:ViewBag.Domain %>">Back to list of important <%:ViewBag.Domain %> tasks</a></p>
    <h2 style="color: Black;">
        Task : <%: ViewBag.Task.ShortText %></h2>
    <%if (ViewBag.IsSelf) 
          Response.Write(ViewBag.Task.AssessmentTextSelf);
          else 
          Response.Write(ViewBag.Task.AssessmentText);
      %>
    <div>
        <div style="width: 450px; float: left;padding-top:20px; ">
            <%foreach (var s in Model)
              {%>
            <div style="cursor: pointer;" class="state" statecode="<%:s.StateCode %>" >
                <%: s.StateName %></div>
            <%} %>
        </div>
        <div style="width: 450px; padding-top:20px; float: right; height: 100%; overflow: auto;" class="task-box">
        <!-- repeating content here.  Have title, URL, and often  (but not always) a short description -->
            <b><a href="http://www.caregiver.org/caregiver/jsp/fcn_content_node.jsp?nodeid=2128">
                Montana Family Caregiver Alliance</a></b> The Montana Family Caregiver Alliance
            is comprised of a vast assortment of publications and services at the national,
            state, and local levels to help meet the needs of caregivers.
            <hr />
            <b><a href="http://www.caregiver.org/caregiver/jsp/fcn_content_node.jsp?nodeid=2128">
                Montana Family Caregiver Alliance</a></b> The Montana Family Caregiver Alliance
            is comprised of a vast assortment of publications and services at the national,
            state, and local levels to help meet the needs of caregivers.
            <hr />
            <b><a href="http://www.caregiver.org/caregiver/jsp/fcn_content_node.jsp?nodeid=2128">
                Montana Family Caregiver Alliance</a></b> The Montana Family Caregiver Alliance
            is comprised of a vast assortment of publications and services at the national,
            state, and local levels to help meet the needs of caregivers.
            <hr />
        </div>
    </div>
    
    <Div style="clear:both;"></Div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
<script language="javascript" type="text/javascript">
    $(document).ready(function () {

        $(".state").click(
            function () {
                var statecode = $(this).attr("statecode");
                SetState(statecode);
            }
        );

        SetState('<%: ViewBag.State %>');
    });

    function SetResources(data) {
        var html = "";
        for (var i = 0; i < data.length; i++) {
            if (html != "") html += "<hr />";

            html += "<b><a href=" + data[i].URL + ">" + data[i].Name + "</a></b><br />";
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
