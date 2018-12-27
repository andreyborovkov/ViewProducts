<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="XEx23ViewProducts.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ch23: View Products</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/site.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <header class="jumbotron"><%-- image set in site.css --%></header>
    <main>
        <form id="form1" runat="server" class="form-horizontal">
            <h1>View Our Products By Category</h1>

            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

            <div class="row">
                <div class="col-sm-8 table-responsive">
                    <label class="col-sm-4 control-label">Choose a category:</label>
                    <div class="col-sm-5">
                        <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True"
                            CssClass="form-control" DataSourceID="SqlDataSource1" 
                            DataTextField="LongName" DataValueField="CategoryID" 
                            OnSelectedIndexChanged="Reset">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                            ConnectionString="<%$ ConnectionStrings:HalloweenConnection %>"
                            SelectCommand="SELECT [CategoryID], [LongName]
                                            FROM [Categories] ORDER BY [LongName]">
                        </asp:SqlDataSource>
                    </div>
                    <asp:Button ID="btnClear" runat="server" Text="Clear Details"
                        OnClick="Reset" CssClass="btn" />

                    <asp:UpdatePanel ID="pnlProducts" runat="server">
                        <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlCategory"
                            EventName="SelectedIndexChanged" />
                        </Triggers>
                        <ContentTemplate>
                        <asp:GridView ID="grdProducts" runat="server" AutoGenerateColumns="false" 
                            DataSourceID="SqlDataSource2" DataKeyNames="ProductID" 
                            CssClass="table table-bordered table-striped table-condensed"
                            OnSelectedIndexChanged="grdProducts_SelectedIndexChanged" 
                            OnPreRender="GridView_PreRender">
                            <Columns>
                                <asp:CommandField ShowSelectButton="true" SelectText="View" />
                                <asp:BoundField DataField="ProductID" HeaderText="ID"
                                    ReadOnly="True" />
                                <asp:BoundField DataField="Name" HeaderText="Name" />
                                <asp:BoundField DataField="UnitPrice" HeaderText="Price"
                                    DataFormatString="{0:c}" />
                                <asp:BoundField DataField="OnHand" HeaderText="On Hand" 
                                    ItemStyle-CssClass="text-right" />
                            </Columns>
                            <HeaderStyle CssClass="bg-halloween" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                            ConnectionString=
                            "<%$ ConnectionStrings:HalloweenConnection %>"
                            SelectCommand="SELECT [ProductID], [Name], [UnitPrice], [OnHand]
                                            FROM [Products] WHERE ([CategoryID] = @CategoryID)
                                            ORDER BY [ProductID]">
                            <SelectParameters>
                            <asp:ControlParameter Name="CategoryID" Type="String"
                                ControlID="ddlCategory" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <h2>Product Details</h2>
                        <asp:DetailsView ID="dvwProduct" runat="server" AutoGenerateRows="False" 
                            DataKeyNames="ProductID" DataSourceID="SqlDataSource3" 
                            CssClass="table table-bordered table-condensed">
                            <Fields>
                                <asp:BoundField DataField="ProductID" HeaderText="ID"
                                    ReadOnly="True" />
                                <asp:BoundField DataField="Name" HeaderText="Name" />
                                <asp:BoundField DataField="UnitPrice" HeaderText="Price"
                                    DataFormatString="{0:c}" />
                                <asp:BoundField DataField="OnHand" HeaderText="On Hand" />
                                <asp:BoundField DataField="ShortDescription" HeaderText="Short
                                    Description" />
                                <asp:BoundField DataField="LongDescription" HeaderText="Long
                                    Description" />
                                <asp:BoundField DataField="CategoryID" HeaderText="Category ID" />
                            </Fields>
                        </asp:DetailsView>
                        <asp:SqlDataSource runat="server" ID="SqlDataSource3" 
                            ConnectionString=
                            '<%$ ConnectionStrings:HalloweenConnection %>' 
                            SelectCommand="SELECT [ProductID], [Name], [ShortDescription],
                            [LongDescription], [CategoryID], [UnitPrice], [OnHand] 
                            FROM [Products] WHERE ([ProductID] = @ProductID)">
                            <SelectParameters>
                            <asp:ControlParameter ControlID="grdProducts" Type="String"
                                PropertyName="SelectedValue" Name="ProductID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        </ContentTemplate>      
                    </asp:UpdatePanel>
                </div>

                <div class="col-sm-4 table-responsive">
                    <h2>Most viewed</h2>
                    <asp:UpdatePanel ID="pnlViews" runat="server">
                        <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="grdProducts"
                            EventName="SelectedIndexChanged" />
                        </Triggers>
                        <ContentTemplate>
                        <asp:GridView ID="grdViews" runat="server"
                            AutoGenerateColumns="false" OnPreRender="GridView_PreRender" 
                            CssClass="table table-bordered table-condensed">
                            <Columns>
                                <asp:BoundField DataField="ProductName" HeaderText="Product" />
                                <asp:BoundField DataField="ViewCount" HeaderText="Views" />
                                <asp:BoundField DataField="CategoryID" HeaderText="CatID" />
                            </Columns>
                            <HeaderStyle CssClass="bg-halloween" />
                        </asp:GridView>
                        
                         <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                             <ProgressTemplate><div class="spinner"><img src="Images/spinner.gif" alt="Please Wait" />Loading...</div></ProgressTemplate>
                         </asp:UpdateProgress>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

            </div>
        </form>
    </main>
</div>
</body>
</html>