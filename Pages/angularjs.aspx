<!DOCTYPE html>
<html lang="pt-BR" ng-app="crudAngular">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style>
        .headerMenu{
            background-color: #eee;
            width: 100vw;
            padding: 10px;
            margin-bottom: 70px;
        }
        .card{
            padding: 20px;
            margin-top: 70px
        }
        .card-body{
            margin-top: 5px;
        }
    </style>
</head>
<body ng-controller="HomeCtrl">
    <header class="headerMenu">
        <h2>{{Title}}</h2>
    </header>
    <div class="container">
        <section>
            <header>
                <div class="form-group">
                    <input class="form-control" placeholder="Pesquisa" type="text"/>
                </div>
            </header>
            <div class="card">
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <button class="btn btn-primary me-md-2" type="button">Novo item</button>
                  </div>
                <div class="card-body">                    
                    <table class="table">
                        <thead>                    
                            <th>Titulo</th>
                            <th>Lookup</th>
                            <th>Anexos</th>
                            <th>Acoes</th>
                        </thead>
                        <tbody>
                            <tr ng-repeat="item in Items">
                                <td>{{item.Title}}</td>
                                <td>{{item.Lookup}}</td>
                                <td><a href="{{item.Anexo}}">Anexos</a></td>
                                <td>
                                    <button class="btn btn-warning">Edit</button>
                                    <button class="btn btn-delete">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
        </div>
        </section>
    </div>
</body>
<script src="/sites/angularjs/style library/custom/myapp/pnp.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
<script>
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
</script>
</html>