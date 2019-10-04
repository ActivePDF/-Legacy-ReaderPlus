<%--
Copyright (c) 2019 ActivePDF, Inc.
ActivePDF Reader Plus
--%>

<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Anti_Forgery.aspx.vb" Inherits="Anti_Forgery" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>DocSpace&#x2122; Reader Plus Anti Forgery Sample</title>

        <!-- jQuery -->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

        <!-- Reader Plus -->
        <script src="http://localhost:62625/index.js"></script>
        <link rel="stylesheet" href="http://localhost:62625/index.css">

        <script>
            window.onload = function () {

                // Initialization settings
                readerplus.initializeSettings({
                    protocol: "http",
                    hostname: 'localhost',
                    port: 62625,
                    language: 'en',
                });

                readerplus.Document.addEventListener("load", function () {
                    // On document load you can add addtional options such as 
                    // adding annotations, populating form fields and controlling 
                    // elements of the user interface
                });

                // Document can be saved to any location when it is submitted by a user
                readerplus.Document.addEventListener("submit", function (strResult) {
                    var result = JSON.parse(strResult);
                    if (result.Status !== 0) {
                        // Display alert on error
                        alert('Document failed to submit!');
                        console.error(result.Details);
                        return
                    }
                    // Open the submitted document in another tab and redirect to thankyou.html
                    var submittedPDFData = result.Details;
                    var base64 = encodeURI(submittedPDFData);
                    if (window.navigator.msSaveOrOpenBlob) {
                        var byteCharacters = atob(base64);
                        var byteNumbers = new Array(byteCharacters.length);
                        for (var i = 0; i < byteCharacters.length; i++) {
                            byteNumbers[i] = byteCharacters.charCodeAt(i);
                        }
                        var byteArray = new Uint8Array(byteNumbers);
                        var blob = new Blob([byteArray], { type: 'application/pdf' });
                        window.navigator.msSaveOrOpenBlob(blob, 'DocumentName.pdf');
                    } else {
                        var style = '<style>html,body{margin:0;width:100%;height:100%;}\niframe{border:none;}</style>';
                        var iFrame = '<iframe width="100%" height="100%" src="data:application/pdf;base64, ' + base64 + '"></iframe>';
                        window.open("").document.write(style + iFrame);
                    }
                    setTimeout(function () { window.location = "thankyou.html" }, 100);
                });

                // Open document
                $.ajax({
                    type: "POST",
                    url: "Anti_forgery.aspx/GetPDFData",
                    data: "{}",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    success: function (data) {
                        // Document settings
                        var isMasterDocument = 0;
                        var editMode = 1;

                        // Upload the document into the viewer
                        var result = readerplus.Document.upload(data.d, isMasterDocument, editMode, "", "DocumentName.pdf");
                        if (result.Status === 0) {
                            // Save document ID in order to reopen a document from the Reader Plus data store
                            var docID = readerplus.Document.getDocumentID();
                            // Open document in edit mode
                            readerplus.Document.edit(docID);
                        }
                        else {
                            // Display alert on error
                            alert('Document failed to open!')
                            console.error(result.Details);
                        }
                    },
                    error: function (xhr, status, error) {
                        alert("Document failed to open!");
                    }
                });

            }
        </script>
    </head>
    <body>
        <div id="ReaderPlus" class="readerplus" style="width: 100%; height: 650px"></div>
    </body>
</html>
