import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:get/get.dart';
import 'package:mmusic/common_widget/category_cell.dart';
import 'package:mmusic/common_widget/title_selection.dart';
import 'package:mmusic/common_widget/your_artist_cell.dart';
import 'package:mmusic/common_widget/your_library_cell.dart';
import 'package:mmusic/common_widget/your_playlist_cell.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view_model/album_model.dart';
import 'package:mmusic/view_model/arist_model.dart';
import 'package:mmusic/view_model/category_model.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/song_model.dart';
class SearchView extends StatefulWidget {
  final SongHandler songHandler;
  const SearchView({super.key, required this.songHandler});
  @override
  State<SearchView> createState() => _SearchViewState();
}


class _SearchViewState extends State<SearchView> {

  late TextEditingController search ;
  @override
  void initState() {
    super.initState();
    search = homeVM.txtSearch.value;
    search.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    search.removeListener(_onSearchChanged);
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {

    });
  }
  final Future<List<CategoryModel>> categoriesArr = HomeViewModel().getAllCategory();
  final Future<List<SongModel>> songArr = HomeViewModel().getDataSong();
  final Future<List<Artist>>  artistArrAll = HomeViewModel() .getDataArist();
  final Future<List<AlbumModel>> albumArr  = HomeViewModel().getAllAlbum();
  final homeVM = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      titleSpacing: 0.0,
      leadingWidth: 70,
      backgroundColor: TColor.primary30,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Image.asset(
          'assets/img/logo_app.png',
          width: 50,
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
      title:
      Container(
        margin: const EdgeInsets.only(left: 5),
        child: Text(
          "Tìm kiếm",
          style: TextStyle(
              color: TColor.primary,
              fontSize: 27,
              fontWeight: FontWeight.w700
          ),
        ),
      ),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  TColor.primary30,
                  Colors.transparent,
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Center(
                 child: Container(
                   margin: const EdgeInsets.only(top: 30,left: 35,right: 40,bottom: 20),
                    height: 50,
                    alignment: Alignment.center,
                    transformAlignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: TColor.primaryText,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: search,
                      style: TextStyle(
                        color: TColor.bg,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(left: 20,bottom: 1,top: 1,right: 1),
                          alignment: Alignment.centerLeft,
                          width: 48,
                          child: Icon(
                            weight: 20,
                            Icons.search,
                            color: Colors.black.withOpacity(0.28),
                          ),
                        ),
                        hintText: "Nhập tên bài hát hoặc tên ca sĩ",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.28),
                          fontSize: 13,
                        )
                      ),
                    ),
                  ),
               ),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const TitleSelection(title: "Dành cho bạn"),
                          SizedBox(
                            height: 280,
                            child: FutureBuilder<List<CategoryModel>>(
                              future: categoriesArr,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return const Center(child: Text('Đã xảy ra lỗi'));
                                } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                                  return const Center(child: Text('Không có dữ liệu danh mục'));
                                }
                                final categories = snapshot.data!;
                                return GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    mainAxisExtent: 110,),
                                  itemCount: 4,
                                  itemBuilder: (context,index){
                                    return CategoryCell(songHandler: widget.songHandler,category: categories[index],);
                                  },
                                );
                              }
                            ),
                          ),
                          const TitleSelection(title: "Tất cả"),
                          SizedBox(
                            child: FutureBuilder<List<CategoryModel>>(
                              future: categoriesArr,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return const Center(child: Text('Đã xảy ra lỗi'));
                                } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                                  return const Center(child: Text('Không có dữ liệu danh mục'));
                                }
                                final categories = snapshot.data!;
                                return GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    mainAxisExtent: 110,),
                                  itemCount: categories.length,
                                  itemBuilder: (context,index){
                                    return CategoryCell(songHandler: widget.songHandler,category: categories[index],);
                                  },
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color:  TColor.bg,
                      child: Container(
                        padding:const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                TColor.primary.withOpacity(0.15),
                                Colors.transparent,
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildArtists(context),
                              _buildAlbums(context),
                              _buildSongs(context)

                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          )
        ),
    );
  }
  Widget _buildArtists(BuildContext context) {
    return FutureBuilder<List<Artist>>(
      future: artistArrAll,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Đã xảy ra lỗi'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có dữ liệu nghệ sĩ'));
        }
        final artists = snapshot.data!;
        final searchQuery = search.text.toLowerCase();

        // Nếu không có văn bản tìm kiếm, không hiển thị danh sách
        if (searchQuery.isEmpty) {
          return const SizedBox.shrink(); // Trả về widget rỗng khi không có văn bản tìm kiếm
        }

        // Lọc nghệ sĩ theo tên
        final filteredArtists = artists.where((artist) {
          return artist.name.toLowerCase().contains(searchQuery);
        }).toList();

        // Nếu không có nghệ sĩ nào khớp với tìm kiếm, có thể hiển thị thông báo
        if (filteredArtists.isEmpty) {
          return const Center(child: Text('Không tìm thấy nghệ sĩ nào'));
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: filteredArtists.length > 4 ? 4: filteredArtists.length,
          itemBuilder: (context, index) {
            final artist = filteredArtists[index];
            return YourArtistCell(artist: artist,songHandler: widget.songHandler,);
          },
        );
      },
    );
  }

  Widget _buildAlbums(BuildContext context){
    return FutureBuilder<List<AlbumModel>>(
      future: albumArr,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Đã xảy ra lỗi'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có dữ liệu album sĩ'));
        }
        final albums = snapshot.data!;
        final searchQuery = search.text.toLowerCase();

        // Nếu không có văn bản tìm kiếm, không hiển thị danh sách
        if (searchQuery.isEmpty) {
          return const SizedBox.shrink(); // Trả về widget rỗng khi không có văn bản tìm kiếm
        }

        // Lọc nghệ sĩ theo tên
        final filteredAlbums = albums.where((song) {
          return song.name.toLowerCase().contains(searchQuery);
        }).toList();

        // Nếu không có nghệ sĩ nào khớp với tìm kiếm, có thể hiển thị thông báo
        if (filteredAlbums.isEmpty) {
          return const Center(child: Text('Không tìm thấy album'));
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: filteredAlbums.length > 4 ? 4: filteredAlbums.length,
          itemBuilder: (context, index) {
            final song = filteredAlbums[index];
            return YourPlaylistCell(albumModel: song, songHandler: widget.songHandler);
          },
        );
      },
    );
  }
  Widget _buildSongs(BuildContext context){
    return FutureBuilder<List<SongModel>>(
      future: songArr,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Đã xảy ra lỗi'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có dữ liệu nghệ sĩ'));
        }
        final songs = snapshot.data!;
        final searchQuery = search.text.toLowerCase();

        // Nếu không có văn bản tìm kiếm, không hiển thị danh sách
        if (searchQuery.isEmpty) {
          return const SizedBox.shrink(); // Trả về widget rỗng khi không có văn bản tìm kiếm
        }

        // Lọc nghệ sĩ theo tên
        final filteredSongs = songs.where((song) {
          return song.name.toLowerCase().contains(searchQuery);
        }).toList();

        // Nếu không có nghệ sĩ nào khớp với tìm kiếm, có thể hiển thị thông báo
        if (filteredSongs.isEmpty) {
          return const Center(child: Text('Không tìm thấy bài hát nào'));
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: filteredSongs.length > 4 ? 4: filteredSongs.length,
          itemBuilder: (context, index) {
            final song = filteredSongs[index];
            return LibraryCell(song: song, songHandler: widget.songHandler);
          },
        );
      },
    );
  }
}
