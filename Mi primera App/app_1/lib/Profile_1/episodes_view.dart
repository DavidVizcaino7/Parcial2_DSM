import 'dart:convert';
import 'package:app_1/Profile_1/episodes_details.dart';
import 'package:app_1/models/episodes_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EpisodesView extends StatefulWidget {
  const EpisodesView({super.key});

  @override
  EpisodesViewState createState() => EpisodesViewState();
}

class EpisodesViewState extends State<EpisodesView> {
  List<EpisodeModel> episodes = [];
  bool isLoading = true;
  String? nextPageUrl;
  String? prevPageUrl;

  Future<void> fetchEpisodes(String url) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        var episodesData = data['results'] as List;

        nextPageUrl = data['next'];
        prevPageUrl = data['prev'];

        setState(() {
          episodes = episodesData.map((e) => EpisodeModel.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to load episodes');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error al cargar los episodios: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEpisodes('https://thesimpsonsapi.com/api/episodes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Episodes')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())  
          : episodes.isEmpty
              ? Center(child: Text('No hay episodios disponibles'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: episodes.length,  
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(episodes[index].title),  
                            subtitle: Text('Season: ${episodes[index].season}'),  
                            trailing: Text('Episode ${episodes[index].episodeNumber}'),  
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EpisodeDetailsPage(
                                    episode: episodes[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          ElevatedButton(
                            onPressed: prevPageUrl != null
                                ? () => fetchEpisodes(prevPageUrl!)
                                : null,
                            child: Text('Anterior'),
                          ),
                          
                          ElevatedButton(
                            onPressed: nextPageUrl != null
                                ? () => fetchEpisodes(nextPageUrl!)
                                : null,
                            child: Text('Siguiente'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
