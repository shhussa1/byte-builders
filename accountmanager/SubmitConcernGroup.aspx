<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="SubmitConcernGroup.aspx.cs"
    Inherits="accountmanager.SubmitConcernGroup" %>

<%@ Register
    Src="~/Controls/Navigation.ascx"
    TagPrefix="bb"
    TagName="Navigation" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Create Concern Group | Byte Builders</title>

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


    <main class="concern-page">

        <section class="concern-heading">

            <div>

                <div class="form-eyebrow">
                    Concern group management
                </div>

                <h1>
                    Create concern group
                </h1>

                <p>
                    Create a workplace concern group that employees
                    can select when submitting proposals.
                </p>

            </div>

            <div class="manager-access-badge">
                Manager or Admin
            </div>

        </section>


        <section class="concern-layout">

            <div class="app-card concern-form-card">

                <div class="concern-form-header">

                    <span class="concern-step">
                        New group
                    </span>

                    <h2>
                        Concern group details
                    </h2>

                    <p>
                        Enter a clear name and description so employees
                        know which proposals belong in this group.
                    </p>

                </div>


                <div class="field">

                    <label for="txtConcernGroupName">
                        Concern group name
                    </label>

                    <asp:TextBox
                        ID="txtConcernGroupName"
                        runat="server"
                        CssClass="input"
                        MaxLength="100"
                        placeholder="Example: Workplace Safety" />

                </div>


                <div class="field">

                    <label for="txtConcernGroupDescription">
                        Description
                    </label>

                    <asp:TextBox
                        ID="txtConcernGroupDescription"
                        runat="server"
                        CssClass="input concern-textarea"
                        TextMode="MultiLine"
                        MaxLength="500"
                        placeholder="Describe the concern group and the proposals that should belong to it." />

                    <div class="field-help">
                        Maximum 500 characters.
                    </div>

                </div>


                <asp:Button
                    ID="btnCreateConcernGroup"
                    runat="server"
                    Text="Create concern group"
                    CssClass="primary-button"
                    OnClick="btnCreateConcernGroup_Click" />


                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="message concern-message" />

            </div>


            <aside class="app-card concern-guidance-card">

                <div class="guidance-icon">
                    01
                </div>

                <h2>
                    What happens next?
                </h2>


                <div class="guidance-item">

                    <strong>
                        Group becomes active
                    </strong>

                    <span>
                        New concern groups are created with an
                        Active status.
                    </span>

                </div>


                <div class="guidance-item">

                    <strong>
                        Employees see the group
                    </strong>

                    <span>
                        It will appear in the dropdown when an employee
                        submits a proposal.
                    </span>

                </div>


                <div class="guidance-item">

                    <strong>
                        Proposals stay organized
                    </strong>

                    <span>
                        Managers can review proposals based on their
                        selected concern group.
                    </span>

                </div>

            </aside>

        </section>

    </main>

</form>

</body>
</html>