<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<List<AgingMVC.Models.GetAssessment_Result>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%:ViewBag.Domain %>
    Evaluation
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
    <style>
        div.task
        {
            border-bottom: 1px dotted #CCCCCC;
            clear: both;
            width: 100%;
        }
        
        div.tasktext
        {
            background: none repeat scroll 0 0 #EEEEEE;
            clear: both;
            float: left;
            left: 5px;
            margin: 10px 0 10px 0px;
            padding: 7px;
            position: relative;
            right: 200px;
            width: 350px;
        }
        div.taskcompleted
        {
            position: relative;
            float: left;
            margin: 10px 0 0;
            padding: 7px;
            width: 100px;
        }
                div.taskcompleted h2
        {
            color: #000;
            font-size: 16px;
            padding: 0px;
            margin: 0px;
        }
        
        div.tasktimeline
        {
            position: relative;
            float: left;
            margin: 10px 0 0;
            padding: 7px;
        }
        
        div.taskheader
        {
            position: relative;
            float: left;
            margin: 10px 0 0;
            padding: 7px;
            width: 100px;
        }

        
        div.tasktimeline h2
        {
            color: #000;
            font-size: 16px;
            padding: 0px;
            margin: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {

        });

        $(function () {

            function EnableTaskCompleted(taskId) {
                var value = $('#TaskCompleted.' + taskId).value;
                alert(value);
                $('#TaskTimeline.' + taskId + ' > :input').attr('disabled', '');
            }

            $(".taskcompleted input:radio").change(function () {
                if (event.target.value == "Yes") {

                } else {
                }
            });

            $("#taskDetails").dialog
        });

    </script>
    <div class="heading">
        <h1>
            <%:ViewBag.Domain %>
            Evaluation -
            <%:ViewBag.ObjectiveHeader%></h1>
    </div>
    <div>
        <div class="taskheader">
            <h2>
                These are important tasks for you to complete.</h2>
        </div>
        <div class="taskcompleted">
            <h2>
                Have you completed this task?</h2>
        </div>
        <div class="tasktimeline">
            <h2>
                If not, when do you plan to complete this task?</h2>
        </div>
    </div>
    <form action="/Assessment/<%:ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page %>"
    method="post">
    <% foreach (var task in Model)
       {            
    %>
    <div class="task">
        <div class="tasktext">
            <%=(ViewBag.IsSelf) ? task.PromptTextSelf : task.PromptText %>
            <br />
            <div style="font-size: smaller; display: inline-block; cursor: help;">
                <a>Learn more about this task</a></div>
        </div>
        <div class="taskcompleted">
            <input type="radio" name="TaskCompleted.<%=task.TaskId %>" id="TaskCompleted.<%=task.TaskId %>"
                value="Yes" <%:(task.Completed)?"checked='checked'":"" %> />Yes<br />
            <input type="radio" name="TaskCompleted.<%=task.TaskId %>" id="TaskCompleted.<%=task.TaskId %>"
                value="No" <%:(task.Completed)?"":"checked='checked'" %> />No
        </div>
        <div class="tasktimeline">
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" id="TaskTimeline.<%=task.TaskId %>"
                value="1" />Within 1 month<br />
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" id="TaskTimeline.<%=task.TaskId %>"
                value="2" />Within 3 months<br />
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" id="TaskTimeline.<%=task.TaskId %>"
                value="3" />Within 6 months<br />
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" id="TaskTimeline.<%=task.TaskId %>"
                value="4" />Within 12 months<br />
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" id="TaskTimeline.<%=task.TaskId %>"
                value="5" />12 months or longer
        </div>
    </div>
    <div style="visibility: hidden; height: 0px;" class="taskDetails" id="taskDetails.<%=task.TaskId %>">
        <%=(ViewBag.IsSelf) ? task.AssessmentTextSelf : task.AssessmentText %>
    </div>
    <%} // End looping through tasks %>
    <div>
        <div style="clear: both;">
        </div>
        <div class="bottom_nav">
            <div style="float: left;">
                <a href="/Assessment/<%:ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page - 1 %>"
                    class="back">Back</a></div>
            <div class="rightnav">
                <input style="cursor: pointer;" type="submit" value="Save and Continue" />
            </div>
        </div>
    </div>
    </form>
</asp:Content>
