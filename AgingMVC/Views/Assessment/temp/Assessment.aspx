<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<List<AgingMVC.Models.GetAssessment_Result>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Assessment
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
    <style>
        div.task
        {
            border-bottom: 1px dotted #CCCCCC;
            clear: both;
            width: 100%;
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
        div.tasktimeline
        {
            position: relative;
            float: left;
            margin: 10px 0 0;
            padding: 7px;
        }
        
        div.taskcompleted h2
        {
            color: #000;
            font-size: 16px;
            padding: 0px;
            margin: 0px;
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

        });



    </script>
    <div class="heading">
        <h1>
            Assessment</h1>
    </div>
    <div>
        <div class="tasktext" style="background: none;">
        </div>
        <div class="taskcompleted">
            <h2>
                Completed?</h2>
        </div>
        <div class="tasktimeline">
            <h2>
                Timeline?</h2>
        </div>
    </div>
    <form action="/Assessment/<%:ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page %>"
    method="post">
    <% foreach (var task in Model)
       { 
           
    %>
    <div class="task">
        <div class="tasktext">
            <%=task.ShortText %>
        </div>
        <div class="taskcompleted">
            <input type="radio" name="TaskCompleted.<%=task.TaskId %>" id="TaskCompleted.<%=task.TaskId %>"
                value="Yes" <%:(task.Completed)?"checked='checked'":"" %> />Yes
            <input type="radio" name="TaskCompleted.<%=task.TaskId %>" id="TaskCompleted.<%=task.TaskId %>"
                value="No" <%:(task.Completed)?"":"checked='checked'" %> />No
        </div>
        <div class="tasktimeline">
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" id="TaskTimeline.<%=task.TaskId %>"
                value="1" />1 month
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" id="TaskTimeline.<%=task.TaskId %>"
                value="2" />3 months
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" id="TaskTimeline.<%=task.TaskId %>"
                value="3" />6 months
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" id="TaskTimeline.<%=task.TaskId %>"
                value="4" />1 year
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" id="TaskTimeline.<%=task.TaskId %>"
                value="5" />Never
        </div>
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
                <input type="submit" value="Proceed to Next Objective" />
            </div>
        </div>
    </div>
    </form>
</asp:Content>
