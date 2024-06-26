import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController{
  final txtSearch= TextEditingController().obs;
  //album
  final continueListeningArr = [
    {
      "image":"assets/img/img_1.png",
      "name":"Coffee & Jazz"
    },{
      "image":"assets/img/img_2.png",
      "name":"Coffee & Jazz"
    },{
      "image":"assets/img/img_3.png",
      "name":"Coffee & Jazz"
    },{
      "image":"assets/img/img_4.png",
      "name":"Coffee & Jazz"
    },{
      "image":"assets/img/img_3.png",
      "name":"Coffee & Jazz"
    },{
      "image":"assets/img/img_4.png",
      "name":"Coffee & Jazz"
    },

  ].obs;
  //Nghệ sĩ
  final artistListArr = [
    {
      "image":"assets/img/img_19.png",
      "name":"Sơn tùng M-TP"
    },{
      "image":"assets/img/img_20.png",
      "name":"Phan Mạnh Quỳnh"
    },{
      "image":"assets/img/img_7.png",
      "name":"Coffee & Jazz"
    },{
      "image":"assets/img/img_7.png",
      "name":"Coffee & Jazz"
    },{
      "image":"assets/img/img_7.png",
      "name":"Coffee & Jazz"
    },{
      "image":"assets/img/img_7.png",
      "name":"Coffee & Jazz"
    },
  ].obs;
  //danh cho ban
  final forYouListArr = [
    {
      "image":"assets/img/img_13.png",
      "name":"em của ngày hôm qua",
      "artist":"Sơn tùng MTP"
    },{
      "image":"assets/img/img_14.png",
      "name":"Khi người mình yêu khóc",
      "artist":"Phan Mạnh Quỳnh"
    },{
      "image":"assets/img/img_15.png",
      "name":"Không phải dạng vừa đâu",
      "artist":"Sơn tùng MTP"
    },{
      "image":"assets/img/img_16.png",
      "name":"Khi phải quên đi",
      "artist":"Phan Mạnh Quỳnh"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix",
      "artist":"Boiz"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix",
      "artist":"Boiz"

    },
  ].obs;
  //Nghe gần đây
  final  recentlyListArr =[
    {
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },
  ].obs;
  final  yourFolderListArr =[
    {
      "name":"moods",
      "number":"11"
    },{
      "name":"blends",
      "number":"8"
    },{
      "name":"favs",
      "number":"14"
    },{
      "name":"random",
      "number":"10"
    },
  ].obs;
  //đề xuất
  final playListArr = [

  ].obs;
  final  categoryListArr =[
    {
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },{
      "image":"assets/img/img_7.png",
      "name":"Pop Mix"
    },
  ].obs;

}