﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Assessment.Master"
    Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.Objective>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%:ViewBag.DomainName%>
    Evaluation
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <%=Model.ObjectiveText %></p>
    <iframe src="<%:ViewBag.VideoURL %>" width="950" height="650"></iframe>
    <div>
        <div style="float: left;">
            <a href="/Assessment/<%:ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page - 1 %>"
                class="back">Back</a></div>
        <div class="rightnav">
            <a href="/Assessment/<%:ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page + 1 %>"
                class="back">Proceed to Evaluation Questions</a></div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
</asp:Content>
