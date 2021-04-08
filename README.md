## SharepointComAngularJs

Aqui você encontará o código de como adicionar o angular js no seu crud do sharepoint.


```
angular.module('crudAngular',[]);
    angular.module('crudAngular').controller('HomeCtrl', function($scope){
        $scope.Title = "Aplicacao em Angular Js";
        $scope.Items = [];
        var pnpSetup = function () {
        $pnp.setup({
                sp: {
                    headers: {
                        Accept: "application/json;odata=verbose",
                    },
                    baseUrl: "https://morony.sharepoint.com/sites/AngularJS"
                },
            });
        }
        const getitems = function(){
            $pnp.sp.web.lists.getByTitle("Atividades")
            .items
            .select("*", "AttachmentFiles", "Lista/Title", "Lista/Id")
            .expand("Lista", "AttachmentFiles")
            .get()
            .then(function(res){
                res.map(function(item){
                    $scope.Items.push({
                        Title: item.Title,
                        Lookup: item.Lista === undefined ? "-" : item.Lista.Title,
                        Anexo: item.Attachments ? item.AttachmentFiles.results[0].ServerRelativeUrl : ""
                    })
                });
                $scope.$apply();
            })
        }
        pnpSetup();
        getitems();
    })
```
