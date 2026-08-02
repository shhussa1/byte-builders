<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Dashboard.aspx.cs"
    Inherits="accountmanager.Dashboard" %>

<%@ Register
    Src="~/Controls/Navigation.ascx"
    TagPrefix="bb"
    TagName="Navigation" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Dashboard | Byte Builders</title>

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


    <main class="dashboard-page">

        <section class="dashboard-heading">

            <div class="form-eyebrow">
                Byte Builders workspace
            </div>

            <h1>
                Your dashboard
            </h1>

            <p>
                Choose an action based on your assigned role.
            </p>

        </section>


        <asp:Label
            ID="lblDashboardMessage"
            runat="server"
            CssClass="message dashboard-message" />


        <div class="dashboard-grid">


            <!-- AVAILABLE TO ALL LOGGED-IN USERS -->

            <a href="ProposalStatus.aspx"
               class="dashboard-card">

                <div class="dashboard-card-icon">
                    01
                </div>

                <div class="dashboard-card-content">

                    <span class="dashboard-card-label">
                        Proposals
                    </span>

                    <h2>
                        View Proposal Status
                    </h2>

                    <p>
                        Review the current status and progress of
                        workplace proposals.
                    </p>

                </div>

                <span class="dashboard-card-arrow">
                    →
                </span>

            </a>


            <!-- EMPLOYEE MENU -->

            <asp:Panel
                ID="pnlEmployee"
                runat="server"
                CssClass="dashboard-panel"
                Visible="false">

                <a href="SubmitProposal.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">
                        02
                    </div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Employee action
                        </span>

                        <h2>
                            Submit Proposal
                        </h2>

                        <p>
                            Select an active concern group and
                            submit a workplace proposal.
                        </p>

                    </div>

                    <span class="dashboard-card-arrow">
                        →
                    </span>

                </a>

            </asp:Panel>


            <!-- MANAGER MENU -->

            <asp:Panel
                ID="pnlManager"
                runat="server"
                CssClass="dashboard-panel"
                Visible="false">

                <a href="SubmitConcernGroup.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">
                        03
                    </div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Manager action
                        </span>

                        <h2>
                            Create Concern Group
                        </h2>

                        <p>
                            Create concern groups that employees
                            can select when submitting proposals.
                        </p>

                    </div>

                    <span class="dashboard-card-arrow">
                        →
                    </span>

                </a>


                <a href="SubmittedProposals.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">
                        04
                    </div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Manager review
                        </span>

                        <h2>
                            View Submitted Proposals
                        </h2>

                        <p>
                            Review proposals submitted by employees
                            across all concern groups.
                        </p>

                    </div>

                    <span class="dashboard-card-arrow">
                        →
                    </span>

                </a>


                <a href="UpdateProposalStatus.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">
                        05
                    </div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Manager action
                        </span>

                        <h2>
                            Update Proposal Status
                        </h2>

                        <p>
                            Move proposals through review,
                            approval, implementation, or decline.
                        </p>

                    </div>

                    <span class="dashboard-card-arrow">
                        →
                    </span>

                </a>

            </asp:Panel>


            <!-- ADMIN MENU -->

            <asp:Panel
                ID="pnlAdmin"
                runat="server"
                CssClass="dashboard-panel"
                Visible="false">

                <a href="ManageUsers.aspx"
                   class="dashboard-card dashboard-card-admin">

                    <div class="dashboard-card-icon">
                        06
                    </div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Administration
                        </span>

                        <h2>
                            Manage Users
                        </h2>

                        <p>
                            Assign registered users as Employees
                            or Managers.
                        </p>

                    </div>

                    <span class="dashboard-card-arrow">
                        →
                    </span>

                </a>

            </asp:Panel>

        </div>

    </main>

</form>

</body>
</html>