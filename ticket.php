<?php
include 'config.php';
include 'headers.php';

 // ------------------- Method GET ----------------------
if($_SERVER['REQUEST_METHOD'] == 'GET') :
    if( isset($_GET['id_ticket'])) : 
        $sql = sprintf("SELECT * FROM ticket_user WHERE id_ticket = %d",
            $_GET['id_ticket']
        );
        $response['response'] = "Un ticket avec id " .$_GET['id_ticket'];
    else :
        $sql = "SELECT * FROM ticket_user ORDER BY date";
        $response['response'] = "Tous les tickets";
        // $nomDuArray est un array et dans les crochets c'est le type de reponse (mot invente)
        // après le = "c'est le texte qui sera affiché" --> chaîne de caractère
    endif;
    $result = $connect->query($sql);
    echo $connect-> error;
    $response['data'] = $result->fetch_all(MYSQLI_ASSOC);// $result est un objet et MYSQLI_ASSOC c'est pour dire qu'on utilise un array associatif
    $response['nb_hits'] = $result->num_rows;
endif; // END GET


 // ------------------- Method DELETE ----------------------
if($_SERVER['REQUEST_METHOD'] == 'DELETE') :
    if( isset($_GET['id_ticket'])) :
    $sql = sprintf("DELETE FROM ticket WHERE id_ticket=%d",
            $_GET['id_ticket']);
        $connect->query($sql);
    echo $connect->error;
    $response['response'] = "Suppresion du ticket " . $_GET['id_ticket'];
    else : 
        $response['response'] = "il manque l'id";
        $response['code'] = 500;
    endif;
endif; //END DELETE


 // ------------------- Method POST ----------------------

if($_SERVER['REQUEST_METHOD'] == 'POST') :
    //extraction de l'obect json du paquet HTTP
    $json = file_get_contents('php://input');
    //décodage du format json, ça génère un obect php
    $objectPOST = json_decode($json);
    $sql = sprintf("INSERT INTO ticket SET tag='%s', `message`='%s', id_user='%s', date='%s'",
        strip_tags($objectPOST->tag),//lire une propriété d'un objet PHP
        strip_tags(addslashes($objectPOST->message)),
        strip_tags($objectPOST->id_user),
        //1,
        date('Y-m-d')
);
    $response['sql'] = $sql;
    $connect->query($sql);
    echo $connect->error;
    $response['response'] = "Ajout d'un ticket";
    $response['new_id'] = $connect->insert_id;
endif; //END POST



// 
//  // ------------------- Method PUT ----------------------
// if($_SERVER['REQUEST_METHOD'] == 'PUT') :
//     //extraction de l'obect json du paquet HTTP
//     $json = file_get_contents('php://input');
//     //décodage du format json, ça génère un obect php
//     $objectPOST = json_decode($json);
//     // on vérifie si on met toutes les données
//     if(isset($objectPOST->tag)) :
//         $sql = sprintf("UPDATE ticket_user SET nom='%s', prix='%s',id_categorie=%d  WHERE id_personnes=%d",
//             addslashes($objectPOST->nom),//lire une propriété d'un objet PHP
//             addslashes($objectPOST->prenom), //addslashes permet d'autorisé les apostrophes et ne pas confondre le simple quote
//             $_GET['id_produit']
//     );
//         $connect->query($sql);
//         echo $connect->error;
//         $response['response'] = "Editer un produit " . $_GET['id_produit'];
//     else : // s'il manque des données
//         $response['response'] = "Il manque des données ";
//         $response['code']  = 500;
//     endif;
// endif; //END PUT

echo Json_encode($response);
