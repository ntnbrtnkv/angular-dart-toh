import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'hero.dart';
import 'hero_service.dart';

@Component(
  selector: 'my-heroes',
  styleUrls: ['hero_list_component.css'],
  templateUrl: 'hero_list_component.html',
  directives: [coreDirectives],
  providers: [ClassProvider(HeroService)],
  pipes: [commonPipes],
)
class HeroListComponent implements OnInit {
  final HeroService _heroService;
  List<Hero> heroes;
  Hero selected;

  HeroListComponent(this._heroService);

  Future<void> _getHeroes() async {
    heroes = await _heroService.getAll();
  }

  void ngOnInit() => _getHeroes();

  void onSelect(Hero hero) => selected = hero;

  Future<NavigationResult> gotoDetail() => null;
}
