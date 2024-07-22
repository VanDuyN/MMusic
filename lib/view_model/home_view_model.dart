import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/view_model/arist_model.dart';
import 'package:mmusic/view_model/category_model.dart';
import 'package:mmusic/view_model/song_model.dart';


class HomeViewModel extends GetxController{

  Future<List<Artist>> getDataArist() async {
    var jsonResponse = jsonDecode(await API().getAllArist());
    if (jsonResponse['status']) {
      List<dynamic> data = jsonResponse['success'];
      return data.map((item) => Artist.fromJson(item)).toList();
    }
    return [];
  }
  Future<List<SongModel>> getDataSong() async {
    var jsonResponse = jsonDecode(await API().getAllSong());
    if (jsonResponse['status']) {
      List<dynamic> data = jsonResponse['success'];
      return data.map((item) => SongModel.fromJson(item)).toList();
    }
    return [];
  }
  Future<List<SongModel>> getSongByArtist(String id) async {
    var jsonResponse = jsonDecode(await API().getSongByIdArtist(id));
    if (jsonResponse['status']) {
      List<dynamic> data = jsonResponse['success'];
      return data.map((item) => SongModel.fromJson(item)).toList();
    }
    return [];
  }
  Future<List<SongModel>> getSongByCategory(String id) async {
    var jsonResponse = jsonDecode(await API().getSongByIdCategory(id));
    if (jsonResponse['status']) {
      List<dynamic> data = jsonResponse['success'];
      return data.map((item) => SongModel.fromJson(item)).toList();
    }

    return [];
  }
  Future<List<CategoryModel>> getAllCategory() async {
    var jsonResponse = jsonDecode(await API().getAllCategories());
    if (jsonResponse['status']) {
      List<dynamic> data = jsonResponse['success'];
      return data.map((item) => CategoryModel.fromJson(item)).toList();
    }
    return [];
  }

  final txtSearch= TextEditingController().obs;
  //album


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
      "artist":"Sơn tùng MTP",
      "music": "assets/music/emcuangayhomua.mp3"
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
  final yourPlayListArr = [
    {
      "image":"assets/img/img_1.png",
      "name":"Chill",
      "number":"11"
    },{
      "image":"assets/img/img_1.png",
      "name":"Bay",
      "number":"8"
    },{
      "image":"assets/img/img_1.png",
      "name":"Nhạc trẻ",
      "number":"14"
    },{
      "image":"assets/img/img_1.png",
      "name":"Dễ ngủ",
      "number":"10"
    },
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