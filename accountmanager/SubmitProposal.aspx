<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="SubmitProposal.aspx.cs"
    Inherits="accountmanager.SubmitProposal" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Submit Proposal | Byte Builders</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <link href="Styles/site.css"
          rel="stylesheet"
          type="text/css" />

</head>

<body>

<form id="form1" runat="server">

<div class="auth-page">

    <main class="auth-shell">


        <section class="auth-hero">

            <div class="hero-content">

                <div class="brand-header">

                    <img
                        src="Images/byte-builders-b.png"
                        alt="Byte Builders"
                        class="brand-logo" />

                    <div class="brand-wordmark">

                        <span class="brand-byte">
                            BYTE
                        </span>

                        <span class="brand-builders">
                            BUILDERS
                        </span>

                    </div>

                </div>


                <div class="hero-eyebrow">
                    Employee proposals
                </div>


                <h1 class="hero-title">

                    Turn ideas into

                    <span class="gradient-word">
                        action.
                    </span>

                </h1>


                <p class="hero-description">

                    Submit a clear workplace proposal so management
                    can review the concern, understand the suggested
                    solution, and provide progress updates.

                </p>


                <div class="benefits">

                    <div class="benefit">

                        <div class="benefit-icon">
                            01
                        </div>

                        <div>

                            <strong>
                                Describe the concern
                            </strong>

                            <span>
                                Explain what is affecting employees
                            </span>

                        </div>

                    </div>


                    <div class="benefit">

                        <div class="benefit-icon">
                            02
                        </div>

                        <div>

                            <strong>
                                Suggest a solution
                            </strong>

                            <span>
                                Give management something actionable
                            </span>

                        </div>

                    </div>


                    <div class="benefit">

                        <div class="benefit-icon">
                            03
                        </div>

                        <div>

                            <strong>
                                Track the result
                            </strong>

                            <span>
                                Follow the proposal status after submission
                            </span>

                        </div>

                    </div>

                </div>

            </div>

            <div class="aurora-line"></div>

        </section>



        <section class="auth-form-panel">

            <div class="auth-top-link">

                View existing proposals?

                <a href="ProposalStatus.aspx">
                    View status
                </a>

            </div>


            <div class="form-eyebrow">
                New proposal
            </div>


            <h2 class="form-title">
                Submit a proposal
            </h2>


            <p class="form-subtitle">

                Describe your proposed workplace improvement clearly.

            </p>


            <div class="field">

                <label for="txtTitle">
                    Proposal title
                </label>

                <asp:TextBox
                    ID="txtTitle"
                    runat="server"
                    CssClass="input"
                    MaxLength="150"
                    placeholder="Enter a short proposal title" />

            </div>


            <div class="field">

                <label for="txtDescription">
                    Proposal description
                </label>

                <asp:TextBox
                    ID="txtDescription"
                    runat="server"
                    CssClass="input proposal-textarea"
                    TextMode="MultiLine"
                    MaxLength="500"
                    placeholder="Describe the concern and recommended solution" />

            </div>


            <asp:Button
                ID="btnSubmitProposal"
                runat="server"
                Text="Submit proposal"
                CssClass="primary-button"
                OnClick="btnSubmitProposal_Click" />


            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message" />


            <div class="form-divider">
                proposal workflow
            </div>


            <div class="form-footer">

                After submission, the initial status will be

                <strong>
                    Submitted
                </strong>.

            </div>


            <div class="security-note">

                <span class="security-icon">
                    ✓
                </span>

                Your proposal will be stored securely.

            </div>

        </section>

    </main>

</div>

</form>

</body>
</html>