<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="UpdateProposalStatus.aspx.cs"
    Inherits="accountmanager.UpdateProposalStatus" %>

<%@ Register
    Src="~/Controls/Navigation.ascx"
    TagPrefix="bb"
    TagName="Navigation" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Update Proposal Status | Byte Builders</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <link href="Styles/site.css"
          rel="stylesheet"
          type="text/css" />

</head>

<body>

<form id="form1" runat="server">

    <bb:Navigation
        ID="Navigation1"
        runat="server" />

    <main class="update-proposal-page">

        <section class="proposal-status-heading">

            <div>

                <div class="form-eyebrow">
                    Proposal management
                </div>

                <h1>
                    Update Proposal Status
                </h1>

                <p>
                    Review employee proposals and update their
                    progress through the proposal workflow.
                </p>

            </div>

            <div class="manager-access-badge">
                Manager / Admin access
            </div>

        </section>

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="message update-proposal-message" />

        <section class="app-card proposal-table-card">

            <div class="proposal-table-header">

                <div>

                    <span class="proposal-table-eyebrow">
                        Proposal management
                    </span>

                    <h2>
                        Submitted Proposals
                    </h2>

                </div>

                <div class="proposal-table-note">
                    Select a new status and click Update.
                </div>

            </div>

            <div class="proposal-table-scroll">

                <asp:GridView
                    ID="gvProposals"
                    runat="server"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    DataKeyNames="proposal_id"
                    CssClass="proposal-grid update-proposal-grid"
                    OnRowCommand="gvProposals_RowCommand"
                    EmptyDataText="No proposals are currently available.">

                    <Columns>

                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>

                                <span class="proposal-id-column">
                                    <%# Eval("proposal_id") %>
                                </span>

                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Proposal">
                            <ItemTemplate>

                                <div class="proposal-title-cell">

                                    <strong>
                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("title")
                                            )
                                        ) %>
                                    </strong>

                                    <span>
                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("description")
                                            )
                                        ) %>
                                    </span>

                                </div>

                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Current Status">
                            <ItemTemplate>

                                <span class='<%#
                                    "proposal-status-pill " +
                                    GetStatusClass(
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

                        <asp:TemplateField HeaderText="New Status">
                            <ItemTemplate>

                                <asp:DropDownList
                                    ID="ddlStatus"
                                    runat="server"
                                    CssClass="status-dropdown">

                                    <asp:ListItem
                                        Text="Submitted"
                                        Value="Submitted" />

                                    <asp:ListItem
                                        Text="Under Review"
                                        Value="Under Review" />

                                    <asp:ListItem
                                        Text="Approved"
                                        Value="Approved" />

                                    <asp:ListItem
                                        Text="Rejected"
                                        Value="Rejected" />

                                    <asp:ListItem
                                        Text="Implemented"
                                        Value="Implemented" />

                                </asp:DropDownList>

                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>

                                <asp:Button
                                    ID="btnUpdate"
                                    runat="server"
                                    Text="Update"
                                    CssClass="proposal-update-button"
                                    CommandName="UpdateProposalStatus"
                                    CommandArgument='<%# Eval("proposal_id") %>' />

                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </div>

        </section>

        <div class="group-details-footer">

            <a href="Dashboard.aspx"
               class="secondary-link-button">

                Return to Dashboard

            </a>

        </div>

    </main>

</form>

</body>
</html>