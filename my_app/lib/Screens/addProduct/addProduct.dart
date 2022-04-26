import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api/firebase_take_file.dart';

class Categorie {
  final String text;
  final List<Categorie> arr;

  Categorie({
    required this.text,
    required this.arr,
  });
}

List<String> matiere = [
  "Acajou",
  "Acier",
  "Acier (inoxydable)",
  "Acrylique",
  "Alpaga",
  "Aluminium",
  "Ambre",
  "Angora",
  "Ardoise",
  "Argent",
  "Argile",
  "Autre",
  "Bambou",
  "Béton / Ciment",
  "Bois",
  "Bois (flotté)",
  "Bronze",
  "Cachemire",
  "Caoutchouc",
  "Carton",
  "Céramique",
  "Chanvre",
  "Chêne",
  "Cire",
  "Coco",
  "Coquillage",
  "Corail",
  "Corde",
  "Coton",
  "Coton (bio)",
  "Coton (enduit)",
  "Crêpe (tissu)",
  "Cristal",
  "Cristal (swarovski)",
  "Cuir",
  "Cuivre",
  "Daim",
  "Dentelle",
  "Douillette",
  "Elasthanne",
  "Email",
  "Eponge",
  "Etain",
  "Etamine",
  "Faïence",
  "Fer",
  "Feutrine",
  "Fibres mélangées",
  "Ficelle",
  "Fil de couture",
  "Fil de fer",
  "Fil de nylon",
  "Fil polyester",
  "Fimo",
  "Flanelle",
  "Fourrure",
  "Fourrure (fausse)",
  "Gouache",
  "Graine",
  "Grès",
  "Hêtre",
  "Huile",
  "Inox",
  "Ivoire (végétal)",
  "Jade",
  "Jaspe",
  "Jean",
  "Jean (denim)",
  "Jersey",
  "Jute",
  "Laine",
  "Laine (mohair)",
  "Laine feutrée/Laine (feutrée)",
  "Laiton",
  "Latex",
  "Liège",
  "Lin",
  "Madras",
  "Marbre",
  "Matelassé",
  "Matières végétales",
  "Mérinos",
  "Merisier",
  "Métal",
  "Métal (argenté)",
  "Métal (couleur bronze)",
  "Métal (couleur cuivre)",
  "Métal (doré)",
  "Métal (rhodié)",
  "Miroir",
  "Mosaique",
  "Mousse",
  "Mousseline",
  "Nacre",
  "Noyer",
  "Nylon",
  "Oeuf Véritable",
  "Or",
  "Or (blanc)",
  "Or (gold filled)",
  "Or (jaune)",
  "Or (rose)",
  "Organza",
  "Os, corne",
  "Osier et rotin",
  "Ouate",
  "Paille",
  "Papier",
  "Pastel",
  "Pate de verre",
  "Pâte polymère",
  "Peaux",
  "Perle",
  "Perle (au chalumeau)",
  "Perle (de verre)",
  "Pierre",
  "Pierre (de gemmes)",
  "Pierres (fines)",
  "Pierres (organiques)",
  "Pierres (précieuses)",
  "Pierres (synthétiques)",
  "Pin",
  "Plaqué Argent",
  "Plaqué Or",
  "Plastique",
  "Platine",
  "Plâtre",
  "Plexiglass",
  "Plume",
  "Polaire",
  "Polyamide",
  "Polyester",
  "Polyéthylène",
  "Polyphane",
  "Polystyrène",
  "Porcelaine",
  "Porcelaine (froide)",
  "Porcelaine fine",
  "Raphia",
  "Résine",
  "Rhodium",
  "Rocaille",
  "Sables",
  "Satin",
  "Savon",
  "Silicone",
  "Simili cuir",
  "Soie",
  "Strass",
  "Stretch",
  "Suédine",
  "Synthétique",
  "Taffetas",
  "Tek",
  "Tencel d’eucalyptus",
  "Terre cuite",
  "Tissu",
  "Tissu (japonais)",
  "Titane",
  "Toile",
  "Toile (cirée)",
  "Toile (de jouy)",
  "Toile (enduite)",
  "Tulle",
  "Végétal",
  "Velours",
  "Velours (côtelé)",
  "Vermeil",
  "Verre",
  "Verre tchèque de bohème",
  "Vinyle",
  "Viscose",
  "Zinc",
];
Map<String, String> colorisCode = {
  'Ambre': "E67E30",
  'Argent': "CECECE",
  'Aubergine': "370028",
  'Beige': "F3F3D6",
  'Blanc': "FFFFFF",
  'Bleu': "00b2e7",
  'Bleu Marine': "03224C",
  'Bordeaux': "be0926",
  'Brique': "CB4154",
  'Bronze': "614E1A",
  'Camel': "C19A6B",
  'Chair': "FEC3AC",
  'Corail': "E73E01",
  'Cuivre': "B36700",
  'Doré Rose': "FFE4B5",
  'Eau': "7FFFD4",
  'Ecru': "FEFEE0",
  'Fuschia': "e41370",
  'Gris': "8c8c8c",
  'Ivoire': "fffff0",
  'Jaune': "fcea10",
  'Kaki': "94812B",
  'Kraft': "d5b59c",
  'Lavande': "9683EC",
  'Marron': "935b38",
  'Mauve': "D473D4",
  'Moutarde': "FFDB58",
  'Multicolor': "FFF",
  'Noir': "000000",
  'Or': "FFFF99",
  'Orange': "f29400",
  'Parme': "CFA0E9",
  'Platine': "E5E4E2",
  'Prune': "811453",
  'Rose': "f2aac6",
  'Rouge': "FF0000",
  'Saumon': "F88E55",
  'Taupe': "463F32",
  'Transparent': "FFFFF0",
  'Turquoise': "00a096",
  'Vert': "007325",
  'Violet': "980d7d",
};

List<String> coloris = [
  "Ambre",
  "Argent",
  "Aubergine",
  "Beige",
  "Blanc",
  "Bleu",
  "Bleu Marine",
  "Bordeaux",
  "Brique",
  "Bronze",
  "Camel",
  "Chair",
  "Corail",
  "Cuivre",
  "Doré Rose",
  "Eau",
  "Ecru",
  "Fuschia",
  "Gris",
  "Ivoire",
  "Jaune",
  "Kaki",
  "Kraft",
  "Lavande",
  "Marron",
  "Mauve",
  "Moutarde",
  "Multicolor",
  "Noir",
  "Or",
  "Orange",
  "Parme",
  "Platine",
  "Prune",
  "Rose",
  "Rouge",
  "Saumon",
  "Taupe",
  "Transparent",
  "Turquoise",
  "Vert",
  "Violet",
];

List<String> listTypeTaille = [
  "Tailles universelles",
  "Vêtements H/F",
  "Enfants G/F",
  "Soutiens-Gorges",
  "Bébés",
  "Bagues",
  "Boutons",
  "Bracelets / Divers",
  "Chapeaux / Casquettes",
  "Chaussures",
  "Colliers",
  "Gants",
  "Matériel numérique",
  "Papier / Cadres",
];

List<Categorie> taille = [
  Categorie(
    text: "Tailles universelles",
    arr: [
      Categorie(
        text: "XXS",
        arr: [],
      ),
      Categorie(
        text: "XS",
        arr: [],
      ),
      Categorie(
        text: "S",
        arr: [],
      ),
      Categorie(
        text: "M",
        arr: [],
      ),
      Categorie(
        text: "L",
        arr: [],
      ),
      Categorie(
        text: "XL",
        arr: [],
      ),
      Categorie(
        text: "XXL",
        arr: [],
      ),
      Categorie(
        text: "3XL",
        arr: [],
      ),
      Categorie(
        text: "4XL",
        arr: [],
      ),
      Categorie(
        text: "5XL",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Vêtements H/F",
    arr: [
      Categorie(
        text: "Taille 34",
        arr: [],
      ),
      Categorie(
        text: "Taille 36",
        arr: [],
      ),
      Categorie(
        text: "Taille 38",
        arr: [],
      ),
      Categorie(
        text: "Taille 40",
        arr: [],
      ),
      Categorie(
        text: "Taille 42",
        arr: [],
      ),
      Categorie(
        text: "Taille 44",
        arr: [],
      ),
      Categorie(
        text: "Taille 46",
        arr: [],
      ),
      Categorie(
        text: "Taille 48",
        arr: [],
      ),
      Categorie(
        text: "Taille 50",
        arr: [],
      ),
      Categorie(
        text: "Taille 52",
        arr: [],
      ),
      Categorie(
        text: "Taille 54",
        arr: [],
      ),
      Categorie(
        text: "Taille 56",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Bagues",
    arr: [
      Categorie(
        text: "Taille 44",
        arr: [],
      ),
      Categorie(
        text: "Taille 45",
        arr: [],
      ),
      Categorie(
        text: "Taille 46",
        arr: [],
      ),
      Categorie(
        text: "Taille 47",
        arr: [],
      ),
      Categorie(
        text: "Taille 48",
        arr: [],
      ),
      Categorie(
        text: "Taille 49",
        arr: [],
      ),
      Categorie(
        text: "Taille 50",
        arr: [],
      ),
      Categorie(
        text: "Taille 51",
        arr: [],
      ),
      Categorie(
        text: "Taille 52",
        arr: [],
      ),
      Categorie(
        text: "Taille 53",
        arr: [],
      ),
      Categorie(
        text: "Taille 54",
        arr: [],
      ),
      Categorie(
        text: "Taille 55",
        arr: [],
      ),
      Categorie(
        text: "Taille 56",
        arr: [],
      ),
      Categorie(
        text: "Taille 57",
        arr: [],
      ),
      Categorie(
        text: "Taille 58",
        arr: [],
      ),
      Categorie(
        text: "Taille 59",
        arr: [],
      ),
      Categorie(
        text: "Taille 60",
        arr: [],
      ),
      Categorie(
        text: "Taille 61",
        arr: [],
      ),
      Categorie(
        text: "Taille 62",
        arr: [],
      ),
      Categorie(
        text: "Taille 63",
        arr: [],
      ),
      Categorie(
        text: "Taille 64",
        arr: [],
      ),
      Categorie(
        text: "Taille 65",
        arr: [],
      ),
      Categorie(
        text: "Taille 66",
        arr: [],
      ),
      Categorie(
        text: "Taille 67",
        arr: [],
      ),
      Categorie(
        text: "Taille 68",
        arr: [],
      ),
      Categorie(
        text: "Taille 69",
        arr: [],
      ),
      Categorie(
        text: "Taille 70",
        arr: [],
      ),
      Categorie(
        text: "Taille 71",
        arr: [],
      ),
      Categorie(
        text: "Taille réglable",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Bébés",
    arr: [
      Categorie(
        text: "1 mois",
        arr: [],
      ),
      Categorie(
        text: "3 mois",
        arr: [],
      ),
      Categorie(
        text: "6 mois",
        arr: [],
      ),
      Categorie(
        text: "9 mois",
        arr: [],
      ),
      Categorie(
        text: "12 mois",
        arr: [],
      ),
      Categorie(
        text: "18 mois",
        arr: [],
      ),
      Categorie(
        text: "24 mois",
        arr: [],
      ),
      Categorie(
        text: "36 mois",
        arr: [],
      ),
      Categorie(
        text: "Naissance",
        arr: [],
      ),
      Categorie(
        text: "Poids plume",
        arr: [],
      ),
      Categorie(
        text: "Prématuré",
        arr: [],
      ),
      Categorie(
        text: "Taille Unique",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Boutons",
    arr: [
      Categorie(
        text: "5 mm",
        arr: [],
      ),
      Categorie(
        text: "6 mm",
        arr: [],
      ),
      Categorie(
        text: "7 mm",
        arr: [],
      ),
      Categorie(
        text: "8 mm",
        arr: [],
      ),
      Categorie(
        text: "9 mm",
        arr: [],
      ),
      Categorie(
        text: "10 mm",
        arr: [],
      ),
      Categorie(
        text: "11 mm",
        arr: [],
      ),
      Categorie(
        text: "12 mm",
        arr: [],
      ),
      Categorie(
        text: "13 mm",
        arr: [],
      ),
      Categorie(
        text: "14 mm",
        arr: [],
      ),
      Categorie(
        text: "15 mm",
        arr: [],
      ),
      Categorie(
        text: "16 mm",
        arr: [],
      ),
      Categorie(
        text: "17 mm",
        arr: [],
      ),
      Categorie(
        text: "18 mm",
        arr: [],
      ),
      Categorie(
        text: "19 mm",
        arr: [],
      ),
      Categorie(
        text: "20 mm",
        arr: [],
      ),
      Categorie(
        text: "21 mm",
        arr: [],
      ),
      Categorie(
        text: "22 mm",
        arr: [],
      ),
      Categorie(
        text: "23 mm",
        arr: [],
      ),
      Categorie(
        text: "24 mm",
        arr: [],
      ),
      Categorie(
        text: "25 mm",
        arr: [],
      ),
      Categorie(
        text: "26 mm",
        arr: [],
      ),
      Categorie(
        text: "27 mm",
        arr: [],
      ),
      Categorie(
        text: "28 mm",
        arr: [],
      ),
      Categorie(
        text: "29 mm",
        arr: [],
      ),
      Categorie(
        text: "30 mm",
        arr: [],
      ),
      Categorie(
        text: "31 mm",
        arr: [],
      ),
      Categorie(
        text: "32 mm",
        arr: [],
      ),
      Categorie(
        text: "33 mm",
        arr: [],
      ),
      Categorie(
        text: "34 mm",
        arr: [],
      ),
      Categorie(
        text: "35 mm",
        arr: [],
      ),
      Categorie(
        text: "36 mm",
        arr: [],
      ),
      Categorie(
        text: "37 mm",
        arr: [],
      ),
      Categorie(
        text: "38 mm",
        arr: [],
      ),
      Categorie(
        text: "39 mm",
        arr: [],
      ),
      Categorie(
        text: "40 mm",
        arr: [],
      ),
      // Categorie(
      //   text: "41 mm",
      //   arr: [],
      // ),
      // Categorie(
      //   text: "42 mm",
      //   arr: [],
      // ),
      // Categorie(
      //   text: "43 mm",
      //   arr: [],
      // ),
      // Categorie(
      //   text: "44 mm",
      //   arr: [],
      // ),
      // Categorie(
      //   text: "45 mm",
      //   arr: [],
      // ),
      // Categorie(
      //   text: "46 mm",
      //   arr: [],
      // ),
      // Categorie(
      //   text: "47 mm",
      //   arr: [],
      // ),
      // Categorie(
      //   text: "48 mm",
      //   arr: [],
      // ),
      // Categorie(
      //   text: "49 mm",
      //   arr: [],
      // ),
      Categorie(
        text: "50 mm",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Bracelets / Divers",
    arr: [
      Categorie(
        text: "1 mm",
        arr: [],
      ),
      Categorie(
        text: "2 mm",
        arr: [],
      ),
      Categorie(
        text: "3 mm",
        arr: [],
      ),
      Categorie(
        text: "4 mm",
        arr: [],
      ),
      Categorie(
        text: "5 mm",
        arr: [],
      ),
      Categorie(
        text: "6 mm",
        arr: [],
      ),
      Categorie(
        text: "7 mm",
        arr: [],
      ),
      Categorie(
        text: "8 mm",
        arr: [],
      ),
      Categorie(
        text: "9 mm",
        arr: [],
      ),
      Categorie(
        text: "10 mm",
        arr: [],
      ),
      Categorie(
        text: "11 mm",
        arr: [],
      ),
      Categorie(
        text: "12 mm",
        arr: [],
      ),
      Categorie(
        text: "13 mm",
        arr: [],
      ),
      Categorie(
        text: "14 mm",
        arr: [],
      ),
      Categorie(
        text: "15 mm",
        arr: [],
      ),
      Categorie(
        text: "16 mm",
        arr: [],
      ),
      Categorie(
        text: "17 mm",
        arr: [],
      ),
      Categorie(
        text: "18 mm",
        arr: [],
      ),
      Categorie(
        text: "19 mm",
        arr: [],
      ),
      Categorie(
        text: "20 mm",
        arr: [],
      ),
      Categorie(
        text: "21 mm",
        arr: [],
      ),
      Categorie(
        text: "22 mm",
        arr: [],
      ),
      Categorie(
        text: "23 mm",
        arr: [],
      ),
      Categorie(
        text: "24 mm",
        arr: [],
      ),
      Categorie(
        text: "25 mm",
        arr: [],
      ),
      Categorie(
        text: "d50",
        arr: [],
      ),
      Categorie(
        text: "d55",
        arr: [],
      ),
      Categorie(
        text: "d60",
        arr: [],
      ),
      Categorie(
        text: "d65",
        arr: [],
      ),
      Categorie(
        text: "70",
        arr: [],
      ),
      Categorie(
        text: "Ajustable",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Chapeaux / Casquettes",
    arr: [
      Categorie(
        text: "Taille 48",
        arr: [],
      ),
      Categorie(
        text: "Taille 49",
        arr: [],
      ),
      Categorie(
        text: "Taille 50",
        arr: [],
      ),
      Categorie(
        text: "Taille 51",
        arr: [],
      ),
      Categorie(
        text: "Taille 52",
        arr: [],
      ),
      Categorie(
        text: "Taille 53",
        arr: [],
      ),
      Categorie(
        text: "Taille 54",
        arr: [],
      ),
      Categorie(
        text: "Taille 55",
        arr: [],
      ),
      Categorie(
        text: "Taille 56",
        arr: [],
      ),
      Categorie(
        text: "Taille 57",
        arr: [],
      ),
      Categorie(
        text: "Taille 58",
        arr: [],
      ),
      Categorie(
        text: "Taille 59",
        arr: [],
      ),
      Categorie(
        text: "Taille 60",
        arr: [],
      ),
      Categorie(
        text: "Taille 61",
        arr: [],
      ),
      Categorie(
        text: "Taille 62",
        arr: [],
      ),
      Categorie(
        text: "Taille 63",
        arr: [],
      ),
      Categorie(
        text: "Taille 64",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Chaussures",
    arr: [
      Categorie(
        text: "Pointure 17",
        arr: [],
      ),
      Categorie(
        text: "Pointure 18",
        arr: [],
      ),
      Categorie(
        text: "Pointure 19",
        arr: [],
      ),
      Categorie(
        text: "Pointure 20",
        arr: [],
      ),
      Categorie(
        text: "Pointure 21",
        arr: [],
      ),
      Categorie(
        text: "Pointure 22",
        arr: [],
      ),
      Categorie(
        text: "Pointure 23",
        arr: [],
      ),
      Categorie(
        text: "Pointure 24",
        arr: [],
      ),
      Categorie(
        text: "Pointure 25",
        arr: [],
      ),
      Categorie(
        text: "Pointure 26",
        arr: [],
      ),
      Categorie(
        text: "Pointure 27",
        arr: [],
      ),
      Categorie(
        text: "Pointure 28",
        arr: [],
      ),
      Categorie(
        text: "Pointure 29",
        arr: [],
      ),
      Categorie(
        text: "Pointure 30",
        arr: [],
      ),
      Categorie(
        text: "Pointure 31",
        arr: [],
      ),
      Categorie(
        text: "Pointure 32",
        arr: [],
      ),
      Categorie(
        text: "Pointure 33",
        arr: [],
      ),
      Categorie(
        text: "Pointure 34",
        arr: [],
      ),
      Categorie(
        text: "Pointure 35",
        arr: [],
      ),
      Categorie(
        text: "Pointure 36",
        arr: [],
      ),
      Categorie(
        text: "Pointure 37",
        arr: [],
      ),
      Categorie(
        text: "Pointure 38",
        arr: [],
      ),
      Categorie(
        text: "Pointure 39",
        arr: [],
      ),
      Categorie(
        text: "Pointure 40",
        arr: [],
      ),
      Categorie(
        text: "Pointure 41",
        arr: [],
      ),
      Categorie(
        text: "Pointure 42",
        arr: [],
      ),
      Categorie(
        text: "Pointure 43",
        arr: [],
      ),
      Categorie(
        text: "Pointure 44",
        arr: [],
      ),
      Categorie(
        text: "Pointure 45",
        arr: [],
      ),
      Categorie(
        text: "Pointure 46",
        arr: [],
      ),
      Categorie(
        text: "Pointure 47",
        arr: [],
      ),
      Categorie(
        text: "Pointure 48",
        arr: [],
      ),
      Categorie(
        text: "Pointure 49",
        arr: [],
      ),
      Categorie(
        text: "Pointure 50",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Colliers",
    arr: [
      Categorie(
        text: "33 cm",
        arr: [],
      ),
      Categorie(
        text: "34 cm",
        arr: [],
      ),
      Categorie(
        text: "35 cm",
        arr: [],
      ),
      Categorie(
        text: "36 cm",
        arr: [],
      ),
      Categorie(
        text: "37 cm",
        arr: [],
      ),
      Categorie(
        text: "38 cm",
        arr: [],
      ),
      Categorie(
        text: "39 cm",
        arr: [],
      ),
      Categorie(
        text: "40 cm",
        arr: [],
      ),
      Categorie(
        text: "41 cm",
        arr: [],
      ),
      Categorie(
        text: "42 cm",
        arr: [],
      ),
      Categorie(
        text: "43 cm",
        arr: [],
      ),
      Categorie(
        text: "44 cm",
        arr: [],
      ),
      Categorie(
        text: "45 cm",
        arr: [],
      ),
      Categorie(
        text: "46 cm",
        arr: [],
      ),
      Categorie(
        text: "47 cm",
        arr: [],
      ),
      Categorie(
        text: "48 cm",
        arr: [],
      ),
      Categorie(
        text: "49 cm",
        arr: [],
      ),
      Categorie(
        text: "50 cm",
        arr: [],
      ),
      Categorie(
        text: "51 cm",
        arr: [],
      ),
      Categorie(
        text: "52 cm",
        arr: [],
      ),
      Categorie(
        text: "53 cm",
        arr: [],
      ),
      Categorie(
        text: "54 cm",
        arr: [],
      ),
      Categorie(
        text: "55 cm",
        arr: [],
      ),
      Categorie(
        text: "56 cm",
        arr: [],
      ),
      Categorie(
        text: "57 cm",
        arr: [],
      ),
      Categorie(
        text: "58 cm",
        arr: [],
      ),
      Categorie(
        text: "59 cm",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Enfants G/F",
    arr: [
      Categorie(
        text: "2 ans",
        arr: [],
      ),
      Categorie(
        text: "3 ans",
        arr: [],
      ),
      Categorie(
        text: "4 ans",
        arr: [],
      ),
      Categorie(
        text: "5 ans",
        arr: [],
      ),
      Categorie(
        text: "6 ans",
        arr: [],
      ),
      Categorie(
        text: "7 ans",
        arr: [],
      ),
      Categorie(
        text: "8 ans",
        arr: [],
      ),
      Categorie(
        text: "9 ans",
        arr: [],
      ),
      Categorie(
        text: "10 ans",
        arr: [],
      ),
      Categorie(
        text: "12 ans",
        arr: [],
      ),
      Categorie(
        text: "14 ans",
        arr: [],
      ),
      Categorie(
        text: "16 ans",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Gants",
    arr: [
      Categorie(
        text: "Taille 5",
        arr: [],
      ),
      Categorie(
        text: "Taille 5,5",
        arr: [],
      ),
      Categorie(
        text: "Taille 6",
        arr: [],
      ),
      Categorie(
        text: "Taille 6,5",
        arr: [],
      ),
      Categorie(
        text: "Taille 7",
        arr: [],
      ),
      Categorie(
        text: "Taille 7,5",
        arr: [],
      ),
      Categorie(
        text: "Taille 8",
        arr: [],
      ),
      Categorie(
        text: "Taille 8,5",
        arr: [],
      ),
      Categorie(
        text: "Taille 9",
        arr: [],
      ),
      Categorie(
        text: "Taille 9,5",
        arr: [],
      ),
      Categorie(
        text: "Taille 10",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Matériel numérique",
    arr: [
      Categorie(
        text: "10″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "12″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "14″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "14″ - 4/3",
        arr: [],
      ),
      Categorie(
        text: "15″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "15″ - 4/3",
        arr: [],
      ),
      Categorie(
        text: "17″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "17″ - 4/3",
        arr: [],
      ),
      Categorie(
        text: "3,5″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "4″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "5″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "6″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "7″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "8″ - 16/9",
        arr: [],
      ),
      Categorie(
        text: "9″ - 16/9",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Papier / Cadres",
    arr: [
      Categorie(
        text: "10 x 15 cm",
        arr: [],
      ),
      Categorie(
        text: "10,5 x 14,8 cm (A6)",
        arr: [],
      ),
      Categorie(
        text: "13 x 18 cm",
        arr: [],
      ),
      Categorie(
        text: "14,8 x 21 cm (A5)",
        arr: [],
      ),
      Categorie(
        text: "15 x 20 cm",
        arr: [],
      ),
      Categorie(
        text: "20 x 20 cm",
        arr: [],
      ),
      Categorie(
        text: "20 x 30 cm",
        arr: [],
      ),
      Categorie(
        text: "21 x 29,7 cm (A4)",
        arr: [],
      ),
      Categorie(
        text: "29,7 x 42 cm (A3)",
        arr: [],
      ),
      Categorie(
        text: "30 x 30 cm",
        arr: [],
      ),
      Categorie(
        text: "30 x 40 cm",
        arr: [],
      ),
      Categorie(
        text: "30 x 45 cm",
        arr: [],
      ),
      Categorie(
        text: "30 x 60 cm",
        arr: [],
      ),
      Categorie(
        text: "40 x 40 cm",
        arr: [],
      ),
      Categorie(
        text: "40 x 50 cm",
        arr: [],
      ),
      Categorie(
        text: "40 x 60 cm",
        arr: [],
      ),
      Categorie(
        text: "42 x 59,4 cm (A2)",
        arr: [],
      ),
      Categorie(
        text: "50 x 50 cm",
        arr: [],
      ),
      Categorie(
        text: "50 x 70 cm",
        arr: [],
      ),
      Categorie(
        text: "60 x 80 cm",
        arr: [],
      ),
      Categorie(
        text: "84,1 x 118,9 cm (A0)",
        arr: [],
      ),
      Categorie(
        text: "89,4 x 84.1 cm (A1)",
        arr: [],
      ),
      Categorie(
        text: "Personnalisé",
        arr: [],
      ),
    ],
  ),
  Categorie(
    text: "Soutiens-Gorges",
    arr: [
      Categorie(
        text: "75A",
        arr: [],
      ),
      Categorie(
        text: "75B",
        arr: [],
      ),
      Categorie(
        text: "80A",
        arr: [],
      ),
      Categorie(
        text: "80B",
        arr: [],
      ),
      Categorie(
        text: "85A",
        arr: [],
      ),
      Categorie(
        text: "85B",
        arr: [],
      ),
      Categorie(
        text: "85C",
        arr: [],
      ),
      Categorie(
        text: "85D",
        arr: [],
      ),
      Categorie(
        text: "85E",
        arr: [],
      ),
      Categorie(
        text: "90A",
        arr: [],
      ),
      Categorie(
        text: "90B",
        arr: [],
      ),
      Categorie(
        text: "90C",
        arr: [],
      ),
      Categorie(
        text: "90D",
        arr: [],
      ),
      Categorie(
        text: "90E",
        arr: [],
      ),
      Categorie(
        text: "90F",
        arr: [],
      ),
      Categorie(
        text: "95A",
        arr: [],
      ),
      Categorie(
        text: "95B",
        arr: [],
      ),
      Categorie(
        text: "95C",
        arr: [],
      ),
      Categorie(
        text: "95D",
        arr: [],
      ),
      Categorie(
        text: "95E",
        arr: [],
      ),
      Categorie(
        text: "95F",
        arr: [],
      ),
      Categorie(
        text: "100B",
        arr: [],
      ),
      Categorie(
        text: "100C",
        arr: [],
      ),
      Categorie(
        text: "100D",
        arr: [],
      ),
      Categorie(
        text: "100E",
        arr: [],
      ),
      Categorie(
        text: "100F",
        arr: [],
      ),
      Categorie(
        text: "100G",
        arr: [],
      ),
      Categorie(
        text: "100H",
        arr: [],
      ),
      Categorie(
        text: "105B",
        arr: [],
      ),
      Categorie(
        text: "105C",
        arr: [],
      ),
      Categorie(
        text: "105D",
        arr: [],
      ),
      Categorie(
        text: "105E",
        arr: [],
      ),
      Categorie(
        text: "105F",
        arr: [],
      ),
      Categorie(
        text: "105G",
        arr: [],
      ),
      Categorie(
        text: "105H",
        arr: [],
      ),
      Categorie(
        text: "110B",
        arr: [],
      ),
      Categorie(
        text: "110C",
        arr: [],
      ),
      Categorie(
        text: "110D",
        arr: [],
      ),
      Categorie(
        text: "110E",
        arr: [],
      ),
      Categorie(
        text: "110F",
        arr: [],
      ),
      Categorie(
        text: "110G",
        arr: [],
      ),
      Categorie(
        text: "110H",
        arr: [],
      ),
      Categorie(
        text: "115B",
        arr: [],
      ),
      Categorie(
        text: "115C",
        arr: [],
      ),
      Categorie(
        text: "115D",
        arr: [],
      ),
      Categorie(
        text: "115E",
        arr: [],
      ),
      Categorie(
        text: "115F",
        arr: [],
      ),
      Categorie(
        text: "115G",
        arr: [],
      ),
      Categorie(
        text: "115H",
        arr: [],
      ),
      Categorie(
        text: "120B",
        arr: [],
      ),
      Categorie(
        text: "120C",
        arr: [],
      ),
      Categorie(
        text: "120D",
        arr: [],
      ),
      Categorie(
        text: "120E",
        arr: [],
      ),
      Categorie(
        text: "120F",
        arr: [],
      ),
      Categorie(
        text: "120G",
        arr: [],
      ),
      Categorie(
        text: "120H",
        arr: [],
      ),
      Categorie(
        text: "125B",
        arr: [],
      ),
      Categorie(
        text: "125C",
        arr: [],
      ),
      Categorie(
        text: "125D",
        arr: [],
      ),
      Categorie(
        text: "125E",
        arr: [],
      ),
      Categorie(
        text: "125F",
        arr: [],
      ),
      Categorie(
        text: "125G",
        arr: [],
      ),
      Categorie(
        text: "125H",
        arr: [],
      ),
      Categorie(
        text: "130B",
        arr: [],
      ),
      Categorie(
        text: "130C",
        arr: [],
      ),
      Categorie(
        text: "130D",
        arr: [],
      ),
      Categorie(
        text: "130E",
        arr: [],
      ),
      Categorie(
        text: "130F",
        arr: [],
      ),
      Categorie(
        text: "130G",
        arr: [],
      ),
      Categorie(
        text: "130H",
        arr: [],
      ),
      Categorie(
        text: "135B",
        arr: [],
      ),
      Categorie(
        text: "135C",
        arr: [],
      ),
      Categorie(
        text: "135D",
        arr: [],
      ),
      Categorie(
        text: "135E",
        arr: [],
      ),
      Categorie(
        text: "135F",
        arr: [],
      ),
      Categorie(
        text: "135G",
        arr: [],
      ),
      Categorie(
        text: "135H",
        arr: [],
      ),
    ],
  ),
];

class AddProduct extends StatefulWidget {
  @override
  const AddProduct(
    this.logList,

    //  required this.refreshFunction,
  );
  final Map logList;

  _AddProductState createState() => _AddProductState(logList);
}

class _AddProductState extends State<AddProduct> {
  // late File imageFile;
  bool imageFill = false;
  final picker = ImagePicker();
  List<File> imageFile = [];
  final Map logList;

  _AddProductState(this.logList);
  // _AddProductState();
  chooseImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null)
      setState(() {
        validator = 0;
        imageFile.add(File(pickedFile.path));
        imageFill = true;
      });
  }

  Widget _customPopupItemBuilderExampleColor(
      BuildContext context, String text, bool isSelected) {
    return Container(
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(text),
        leading: Container(
          width: 23,
          height: 23,
          decoration: BoxDecoration(
              color: Color(int.parse("0xff" + colorisCode[text]!)),
              shape: BoxShape.circle),
        ),
      ),
    );
  }

  Widget _customPopupItemBuilderSymbolCat1(
      BuildContext context, String text, bool isSelected) {
    return Container(
        decoration: !isSelected
            ? null
            : BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
        child: ListTile(
          selected: isSelected,
          title: Text(text),
          leading: Container(
            width: 23,
            height: 23,
            child: Icon(Icons.image),
            // decoration: BoxDecoration(
            //     color: Color(int.parse("0xff" + colorisCode[text]!)),
            //     shape: BoxShape.circle),
          ),
        ));
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, String text, bool isSelected) {
    return Container(
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(text),
      ),
    );
  }

  // void takeCat2() {
  //   int i = 0;
  //   int j = 0;

  //   listCat2.clear();
  //   while (categorie[i].text != cat1Value) i++;
  //   while (categorie[i].arr!.length != j) {
  //     listCat2.add(categorie[i].arr![j].text);
  //     j++;
  //   }
  // }

  // void takeTaille() {
  //   int i = 0;
  //   int j = 0;

  //   listTaille.clear();
  //   print(typeTaille);
  //   while (taille[i].text != typeTaille) i++;
  //   print(taille[i].text);
  //   while (taille[i].arr!.length != j) {
  //     listTaille.add(taille[i].arr![j].text);
  //     j++;
  //   }
  // }

  // void takeCat3() {
  //   int i = 0;
  //   int j = 0;
  //   int k = 0;

  //   listCat3.clear();
  //   while (categorie[i].text != cat1Value) i++;
  //   while (categorie[i].arr![j].text != cat2Value) {
  //     j++;
  //   }
  //   if (categorie[i].arr![j].arr == null) return;
  //   while (categorie[i].arr![j].arr!.length != k) {
  //     listCat3.add(categorie[i].arr![j].arr![k].text);
  //     k++;
  //   }
  // }
  void takeTaille() {
    int i = 0;
    int j = 0;

    listTaille.clear();
    print(typeTaille);
    while (taille[i].text != typeTaille) i++;
    print(taille[i].text);
    while (taille[i].arr.length != j) {
      listTaille.add(taille[i].arr[j].text);
      j++;
    }
  }

  Map<dynamic, dynamic> takeData() {
    var data = {};
    if (styleValue != null && styleValue!.length != 0) {
      for (int i = 0; i < styleValue!.length; i++) {
        data.addAll({"STYLE[$i]": styleValue![i]});
      }
    }
    if ((typeTaille != null && typeTaille!.length != 0) &&
        (tailleValue != null && tailleValue!.length != 0)) {
      data["TYPETAILLE"] = typeTaille;
      for (int i = 0; i < tailleValue!.length; i++) {
        data.addAll({"TAILLE[$i]": tailleValue![i]});
      }
    }
    if (colorisValue != null && colorisValue!.length != 0) {
      for (int i = 0; i < colorisValue!.length; i++) {
        data.addAll({"COLORIS[$i]": colorisValue![i]});
      }
    }
    if (matiereValue != null && matiereValue!.length != 0) {
      for (int i = 0; i < matiereValue!.length; i++) {
        data.addAll({"MATIERE[$i]": matiereValue![i]});
      }
    }
    if (marqueValue != null && marqueValue!.length != 0) {
      data["MARQUE"] = marqueValue;
    }
    if (cat1Value != null && cat1Value!.length != 0)
      data.addAll({"CATEGORIES[0]": cat1Value});
    if (cat2Value != null && cat2Value!.length != 0)
      data.addAll({"CATEGORIES[1]": cat2Value});
    if (cat3Value != null && cat3Value!.length != 0)
      data.addAll({"CATEGORIES[2]": cat3Value});
    if (cat4Value != null && cat4Value!.length != 0)
      data.addAll({"CATEGORIES[3]": cat4Value});
    if (nomValue != null && nomValue!.length != 0)
      data.addAll({"NOM": nomValue});

    if (descValue != null && descValue!.length != 0)
      data.addAll({"DESCRIPTION": descValue});

    if (prixAchat != null) data.addAll({"PRIX_ACHAT": prixAchat});

    if (prixVente != null) data.addAll({"PRIX_VENTE": prixVente});

    if (stockValue != null &&
        stockValue != "" &&
        int.parse(stockValue.toString()) != 0)
      data.addAll({"STOCK": stockValue});
    else
      data.addAll({"STOCK": "0"});
    data.addAll({"NBPHOTO": imageFile.length.toString()});

    data.addAll({"VENDU": "0"});
    //TODO: pensez a demander si on doit activer le status
    //TODO: ajouter le nouveau produit au jsonList
    data.addAll({"STATUS": "true"});
    data.addAll({"DATA": new DateTime.now().toString()});
    // setState(() {
    // });
    //data.addAll({"VENDU": 0});
    // catData.add(cat1Value);
    // if (cat2Value != null && cat2Value!.length != 0) catData.add(cat2Value);
    // if (cat3Value != null && cat3Value!.length != 0) catData.add(cat3Value);
    // if (catData != null && catData.length != 0) data["CATEGORIES"] = catData;
    return data;
  }

  Future<void> sendProduct() async {
    var client = http.Client();
    Map data = takeData();
    print(logList);
    data.addAll({"id": logList["MAIL"]});
    try {
      var url =
          "https://us-central1-yomy-cfc3f.cloudfunctions.net/productManageFit-user/fittinghome";
      var response = await http.post(Uri.parse(url), body: data);
      var jsonList = json.decode(response.body);
      for (int i = 0; imageFile.length != i; i++) {
        print("dsqdsdsq");
        final destination =
            "SSrEmhqD8XHRBzUPRnh3/photo/" + logList["MAIL"] + "/$nomValue/$i";
        FirebaseApi.uploadFile(destination, imageFile[i]);
      }
    } finally {
      client.close();
      //Navigator.of(context).pop();
    }
  }

  // void takeCat4() {
  //   int i = 0;
  //   int j = 0;
  //   int k = 0;
  //   int h = 0;

  //   listCat4.clear();
  //   while (categorie[i].text != cat1Value) i++;
  //   while (categorie[i].arr![j].text != cat2Value) {
  //     j++;
  //   }
  //   while (categorie[i].arr![j].arr![k].text != cat3Value) {
  //     k++;
  //   }
  //   if (categorie[i].arr![j].arr![k].arr == null) return;
  //   while (categorie[i].arr![j].arr![k].arr!.length != h) {
  //     listCat4.add(categorie[i].arr![j].arr![k].arr![h].text);
  //     h++;
  //   }
  // }

  final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();
  final _openDropDownProgKey2 = GlobalKey<DropdownSearchState<String>>();
  final _openDropDownProgKey3 = GlobalKey<DropdownSearchState<String>>();
  final _openDropDownProgKey4 = GlobalKey<DropdownSearchState<String>>();

  String? marqueValue;
  String? cat1Value;
  String? cat2Value;
  String? cat3Value;
  String? cat4Value;
  String? nomValue;
  String? descValue;
  String? prixVente;
  String? prixAchat;
  String? stockValue;
  int validator = 0;
  int checkValidator = 0;

  String? persCatValue;
  String? typeTaille;
  List<String>? colorisValue;
  List<String>? styleValue;
  List<String>? tailleValue;
  List<String>? matiereValue;
  bool cat2Active = false;
  bool cat3Active = false;
  bool cat4Active = false;
  bool tailleActive = false;
  List<String> listCat2 = [];
  List<String> listCat3 = [];
  List<String> listCat4 = [];
  List<String> listTaille = [];
  List<Widget> listPhoto = [];
  List<Widget> listStyle = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: new BoxDecoration(color: Colors.white),
            padding: EdgeInsets.only(top: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    child: imageFill != false
                        ? SizedBox(
                            height: 150,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: imageFile.length,
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 15,
                                );
                              },
                              itemBuilder: (context, index) {
                                return Stack(
                                    alignment: Alignment.topRight,
                                    children: <Widget>[
                                      Container(
                                        height: 180,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(imageFile[index]),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.black38,
                                        ),
                                        child: IconButton(
                                          // splashColor: Colors.transparent,
                                          // highlightColor: Colors.transparent,
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.clear,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              imageFile.removeAt(index);
                                              if (imageFile.length == 0) {
                                                imageFill = false;
                                                validator = 1;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ]);
                              },
                            ),
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/addPhoto.png"),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            onPressed: () {
                              chooseImage(ImageSource.camera);
                            },
                            color: Colors.indigo[400],
                            child: Text(
                              "Camera",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            onPressed: () {
                              chooseImage(ImageSource.gallery);
                            },
                            color: Colors.indigo[400],
                            child: Text(
                              "Gallery*",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  validator == 1
                      ? Container(
                          // height: 100,
                          // width: 100,
                          child: Text(
                            "Veuillez choisir au moins une photo",
                            style:
                                TextStyle(fontSize: 12, color: Colors.red[700]),
                          ),
                        )
                      : Container(
                          // height: 100,
                          // width: 100,
                          child: Text(""),
                        ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      top: 20,
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Les champs marqué d'un (*) sont obligatoire",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      top: 20,
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "1 - Informations",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      onChanged: (text) {
                        nomValue = text;
                      },
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return 'Veuillez entrez un nom';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Nom du produit *',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      onChanged: (text) {
                        descValue = text;
                      },
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      onChanged: (text) {
                        prixVente = text;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrez un prix de vente';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Prix de vente (Ex: 10.00) *',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 5.0,
                    height: 5.0,
                  ),

                  Divider(
                    height: 100,
                    thickness: 5,
                    indent: 40,
                    endIndent: 40,
                    color: Colors.indigo[400],
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 10.0, bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "3 - Tailles",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Type de tailles',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                    height: 10.0,
                  ),
                  DropdownSearch<String>(
                    showClearButton: true,
                    items: listTypeTaille,
                    scrollbarProps: ScrollbarProps(
                      isAlwaysShown: true,
                      thickness: 7,
                    ),
                    maxHeight: 300,
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue != null) {
                          if (newValue == typeTaille) {
                            return;
                          }
                          typeTaille = newValue;
                          tailleActive = true;
                          takeTaille();
                          _openDropDownProgKey4.currentState
                              ?.changeSelectedItem(null);
                        } else {
                          _openDropDownProgKey4.currentState
                              ?.changeSelectedItem(null);
                          tailleActive = false;
                          typeTaille = "";
                        }
                      });
                    },
                    showSearchBox: true,
                  ),
                  SizedBox(
                    width: 20.0,
                    height: 20.0,
                  ),
                  Container(
                    child: tailleActive == false
                        ? Text(
                            'Tailles',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          )
                        : Text(
                            'Tailles *',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                  ),
                  SizedBox(
                    width: 10.0,
                    height: 10.0,
                  ),
                  DropdownSearch<String>.multiSelection(
                    showSearchBox: true,
                    key: _openDropDownProgKey4,
                    enabled: tailleActive,
                    scrollbarProps: ScrollbarProps(
                      isAlwaysShown: true,
                      thickness: 7,
                    ),
                    maxHeight: 400,
                    onChanged: (data) {
                      setState(() {
                        tailleValue = data;
                      });
                    },
                    showClearButton: true,
                    items: listTaille,
                    popupItemBuilder: _customPopupItemBuilderExample,
                  ),
                  // DropdownSearch<String>(
                  //   key: _openDropDownProgKey,
                  //   showClearButton: cat2Active,
                  //   items: listCat2,
                  //   enabled: cat2Active,
                  //   showSearchBox: true,
                  //   scrollbarProps: ScrollbarProps(
                  //     isAlwaysShown: true,
                  //     thickness: 7,
                  //   ),
                  //   maxHeight: 300,
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       if (newValue != null) {
                  //         if (cat1Value != newValue) {
                  //           _openDropDownProgKey2.currentState
                  //               ?.changeSelectedItem(null);
                  //           cat3Active = false;
                  //         }
                  //         cat2Value = newValue;
                  //         takeCat3();
                  //         if (listCat3.length > 0)
                  //           cat3Active = true;
                  //         else
                  //           cat3Active = false;
                  //       } else {
                  //         _openDropDownProgKey2.currentState
                  //             ?.changeSelectedItem(null);
                  //         cat2Value = "";
                  //         cat3Value = "";
                  //         cat3Active = false;
                  //       }
                  //     });
                  //   },
                  // ),
                  SizedBox(
                    width: 10.0,
                    height: 5.0,
                  ),
                  Divider(
                    height: 100,
                    thickness: 5,
                    indent: 40,
                    endIndent: 40,
                    color: Colors.indigo[400],
                  ),
                  // SizedBox(
                  //   width: 10.0,
                  //   height: 20.0,
                  // ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "4 - Caractéristiques",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Couleurs (2 maximum)', // (2 maximum)
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                    height: 10.0,
                  ),
                  DropdownSearch<String>.multiSelection(
                    //   mode: Mode.MENU,
                    scrollbarProps: ScrollbarProps(
                      isAlwaysShown: true,
                      thickness: 7,
                    ),
                    showSearchBox: true,

                    maxHeight: 400,
                    onChanged: (data) {
                      setState(() {
                        colorisValue = data;
                      });
                    },
                    showClearButton: true,
                    items: coloris,

                    onBeforeChange: (data, data1) {
                      print(data1);
                      if (data1.length > 2) {
                        AlertDialog alert = AlertDialog(
                          title: Text("2 maximum"),
                          content: Text(
                              "Vous ne pouvez selectionner que 2 couleurs maximum."),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                          ],
                        );

                        return showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            });
                      }

                      return Future.value(true);
                    },
                    popupItemBuilder: _customPopupItemBuilderExampleColor,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Text(
                      'Matières (2 maximum)', // (2 maximum)
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                    height: 10.0,
                  ),
                  DropdownSearch<String>.multiSelection(
                    //   mode: Mode.MENU,
                    scrollbarProps: ScrollbarProps(
                      isAlwaysShown: true,
                      thickness: 7,
                    ),
                    showSearchBox: true,
                    showClearButton: true,

                    maxHeight: 400,
                    onChanged: (data) {
                      setState(() {
                        matiereValue = data;
                      });
                    },

                    items: matiere,
                    popupItemBuilder: _customPopupItemBuilderExample,
                    onBeforeChange: (data, data1) {
                      print(data1);
                      if (data1.length > 2) {
                        AlertDialog alert = AlertDialog(
                          title: Text("2 maximum"),
                          content: Text(
                              "Vous ne pouvez selectionner que 2 matières maximum."),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                          ],
                        );

                        return showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            });
                      }

                      return Future.value(true);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  checkValidator == 1
                      ? Container(
                          // height: 100,
                          // width: 100,
                          child: Text(
                            "Veuillez remplir tous les champs obligatoire",
                            style:
                                TextStyle(fontSize: 12, color: Colors.red[700]),
                          ),
                        )
                      : Container(
                          // height: 100,
                          // width: 100,
                          ),
                  checkValidator == 1
                      ? SizedBox(
                          height: 20.0,
                        )
                      : Container(
                          // height: 100,
                          // width: 100,
                          ),

                  Container(
                    width: 300,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (imageFile.length == 0) validator = 1;
                        });
                        if (_formKey.currentState!.validate() &&
                            imageFile.length >= 1) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Envoi en cours...')),
                          );
                          sendProduct();
                        } else
                          checkValidator = 1;
                        // }
                        //chooseImage(ImageSource.gallery);
                      },
                      color: Colors.indigo[400],
                      child: Text(
                        "Ajouter",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Map<dynamic, dynamic> jsonList;
// final List<isWidget> _userWidget = [];

// Future<void> takeListWidget() async {
//   var client = http.Client();
//   try {
//     var url =
//         "https://us-central1-area-5269b.cloudfunctions.net/app/get_area_user";
//     var response = await http.post(url, body: {
//       'email': isEmail,
//     });
//     print('Response status: ${response.statusCode}');
//     jsonList = json.decode(response.body);
//     //print('Response body: ${response.body}');
//   } finally {
//     client.close();
//   }
// }
