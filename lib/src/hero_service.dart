import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import 'hero.dart';

class HeroService {
  static const _heroesUrl = 'api/heroes';
  static final _headers = {'Content-Type': 'application/json'};

  final Client _http;

  HeroService(this._http);

  Exception _handleError(dynamic e) {
    print(e);
    return Exception('Server error; cause $e');
  }

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Future<List<Hero>> getAll() async {
    try {
      final response = await _http.get(_heroesUrl);
      final heroes = (_extractData(response) as List).map((json) => Hero.fromJson(json)).toList();
      return heroes;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> get(int id) async {
    try {
      final response = await _http.get('$_heroesUrl/$id');
      final hero = Hero.fromJson(_extractData(response));
      return hero;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> update(Hero hero) async {
    try {
      final response = await _http.put('$_heroesUrl/${hero.id}', headers: _headers, body: json.encode(hero));
      return Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> create(String name) async {
    try {
      final response = await _http.post(_heroesUrl, headers: _headers, body: json.encode({'name': name}));
      return Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> delete(int id) async {
    try {
      await _http.delete('$_heroesUrl/$id');
    } catch (e) {
      throw _handleError(e);
    }
  }
}
