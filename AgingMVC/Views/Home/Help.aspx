<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Help
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1>
            Frequently Asked Questions</h1>
    </div>
    <p>
        <div class="faqq">
            What do I do first?</div>
        <div class="faqa">
            Select stuff</div>
    </p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
    <style type="text/css">
        .faqq
        {
        }
        
        .faqa
        {
            display: none;
        }
    </style>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $(".faqq").click(function () {
                $(event.toElement).next(".faqa").toggle();
            });
        });
    </script>
</asp:Content>
