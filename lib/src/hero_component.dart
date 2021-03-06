import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'hero_service.dart';
import 'route_paths.dart';
import 'hero.dart';

@Component(
  selector: 'my-hero',
  templateUrl: 'hero_component.html',
  styleUrls: ['hero_component.css'],
  directives: [coreDirectives, formDirectives],
)
class HeroComponent implements OnActivate {
  final HeroService _heroService;
  final Location _location;
  Hero hero;

  HeroComponent(this._heroService, this._location);

  @override
  void onActivate(RouterState previous, RouterState current) async {
    final id = getId(current.parameters);
    if (id != null) {
      hero = await (_heroService.get(id));
    }
  }

  void goBack() => _location.back();

  void save() async {
    await _heroService.update(hero);
    goBack();
  }
}
