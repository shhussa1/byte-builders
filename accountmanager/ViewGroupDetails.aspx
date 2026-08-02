<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="ViewGroupDetails.aspx.cs"
    Inherits="accountmanager.ViewGroupDetails" %>

<%@ Register
    Src="~/Controls/Navigation.ascx"
    TagPrefix="bb"
    TagName="Navigation" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>View Concern Groups | Byte Builders</title>

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1" />

    <link
        href="Styles/site.css"
        rel="stylesheet"
        type="text/css" />

</head>

<body>

<form id="form1" runat="server">

    <bb:Navigation
        ID="Navigation1"
        runat="server" />

    <main class="group-details-page">

        <section class="proposal-status-heading">

            <div>

                <div class="form-eyebrow">
                    Concern group management
                </div>

                <h1>
                    View concern groups
                </h1>

                <p>
                    Review all concern groups created by Managers.
                    These groups are available for employees to select
                    when submitting workplace proposals.
                </p>

            </div>

            <div class="manager-access-badge">
                Manager access
            </div>

        </section>

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="message group-details-message" />

        <section class="app-card proposal-table-card">

            <div class="proposal-table-header">

                <div>

                    <span class="proposal-table-eyebrow">
                        Concern groups
                    </span>

                    <h2>
                        Available groups
                    </h2>

                </div>

                <div class="proposal-table-note">
                    Created-by information is displayed using the
                    Manager's registered name.
                </div>

            </div>

            <div class="proposal-table-scroll">

                <asp:GridView
                    ID="gvGroups"
                    runat="server"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    CssClass="proposal-grid group-details-grid"
                    EmptyDataText="No concern groups are currently available.">

                    <Columns>

                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <span class="proposal-id-column">
                                    <%# Eval("concern_group_id") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Group name">
                            <ItemTemplate>
                                <span class="group-name">
                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("concern_group_name")
                                        )
                                    ) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <div class="group-description-cell">
                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("concern_group_description")
                                        )
                                    ) %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span
                                    class='<%#
                                        "proposal-status-pill " +
                                        GetGroupStatusClass(
                                            Eval("status")
                                        )
                                    %>'>

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("status")
                                        )
                                    ) %>

                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Created by">
                            <ItemTemplate>
                                <span class="created-by-pill">
                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("created_by_name")
                                        )
                                    ) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Created">
                            <ItemTemplate>
                                <span class="group-created-date">
                                    <%# FormatCreatedDate(
                                        Eval("created_at")
                                    ) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </div>

        </section>

        <div class="group-details-footer">

            <a
                href="Dashboard.aspx"
                class="secondary-link-button">

                Return to dashboard

            </a>

            <a
                href="SubmitConcernGroup.aspx"
                class="primary-link-button">

                Create concern group

            </a>

        </div>

    </main>

</form>

</body>
</html>