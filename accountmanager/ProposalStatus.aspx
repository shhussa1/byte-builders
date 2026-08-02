<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ProposalStatus.aspx.cs"
    Inherits="accountmanager.ProposalStatus" %>

<%@ Register
    Src="~/Controls/Navigation.ascx"
    TagPrefix="bb"
    TagName="Navigation" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Proposal Status | Byte Builders</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <link href="Styles/site.css"
          rel="stylesheet"
          type="text/css" />

</head>

<body>

<form id="form1" runat="server">

    <!-- Shared role-based navigation -->

    <bb:Navigation
        ID="Navigation1"
        runat="server" />


    <main class="proposal-status-page">

        <!-- Page heading -->

        <section class="proposal-status-heading">

            <div>

                <div class="form-eyebrow">
                    Proposal tracking
                </div>

                <h1>
                    Proposal status
                </h1>

                <p>
                    Review workplace proposals, their concern groups,
                    and their current review status.
                </p>

            </div>

            <div class="proposal-status-badge">
                Live status
            </div>

        </section>


        <!-- Message area -->

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="message proposal-status-message" />


        <!-- Proposal table -->

        <section class="app-card proposal-table-card">

            <div class="proposal-table-header">

                <div>

                    <span class="proposal-table-eyebrow">
                        Submitted proposals
                    </span>

                    <h2>
                        Proposal overview
                    </h2>

                </div>

                <div class="proposal-table-note">
                    Status information is provided by management.
                </div>

            </div>


            <div class="proposal-table-scroll">

                <asp:GridView
                    ID="gvProposals"
                    runat="server"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    CssClass="proposal-grid"
                    EmptyDataText="No proposals are currently available."
                    ShowHeaderWhenEmpty="True">

                    <Columns>

                        <asp:BoundField
                            DataField="proposal_id"
                            HeaderText="ID">

                            <ItemStyle CssClass="proposal-id-column" />

                        </asp:BoundField>


                        <asp:TemplateField HeaderText="Concern Group">

                            <ItemTemplate>

                                <span class="concern-group-badge">

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("concern_group_name")
                                        )
                                    ) %>

                                </span>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Proposal">

                            <ItemTemplate>

                                <div class="proposal-title-cell">

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("title")
                                        )
                                    ) %>

                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Description">

                            <ItemTemplate>

                                <div class="proposal-description-cell">

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("description")
                                        )
                                    ) %>

                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Status">

                            <ItemTemplate>

                                <span class='<%# GetStatusCssClass(
                                    Convert.ToString(Eval("status"))
                                ) %>'>

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("status")
                                        )
                                    ) %>

                                </span>

                            </ItemTemplate>

                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </div>

        </section>

    </main>

</form>

</body>
</html>