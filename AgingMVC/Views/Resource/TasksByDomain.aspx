<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<List<AgingMVC.Models.Task>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Domain Tasks
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1> 
        Your Most Important 
        <%:ViewBag.DomainName%> </h1></div>
        <div style="width: 900px; margin-bottom: 20px;" >
        Below are your most important <%:ViewBag.DomainName %>.  Select one of the tasks to learn more about it, then use the <i>View Resources</i> link at the bottom of the description to access local and national resources to help you complete that task.
        </div>
    <div style="width: 450px; clear:tasks; float: left;">
        <%foreach (var task in Model)
          { %>
        <div class="Task" style="cursor: pointer" taskid="<%: task.TaskId %>">
            <%: task.ShortText %></div>
        <%} %>
        <a href="#"></a>
    </div>
    <div style="width: 450px; float: right; ">
        <div id="resourceheader">
        </div>
        <div id="resourcetext">
        </div>
        <div id="resourcefooter">
            <a href="#" id="resourcelink">View Resources to help you complete this task.</a>
        </div>
        
    </div>
    
                <Div style="clear:both;"></Div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
    <script language="javascript" type="text/javascript">

    var taskData = <%=ViewBag.TaskData %>

    $(document).ready(function () {
        $(".Task").click(function(){
            var taskID = $(this).attr("taskid");
            LoadTask(taskID);
        });

        LoadTask(FirstKey(taskData));
    });

    function FirstKey(arr)
    {
        for(var prop in arr)
            return prop;
    }

    function LoadTask(taskID)
    {
        var task = taskData[taskID];
        $("#resourceheader").html('<b>' + task.PromptText + '</b>');
        $("#resourcetext").html(task.AssessmentText);
        $("#resourcelink").attr("href", "/Resources/<%:ViewBag.Parent %>/<%:ViewBag.DomainShortName %>/" + taskID);
        
    }
    </script>
    

</asp:Content>
