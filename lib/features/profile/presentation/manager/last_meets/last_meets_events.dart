abstract class LastMeetsEvents {}

class GetLastMeetsEvent extends LastMeetsEvents {
  final bool refresh;

  GetLastMeetsEvent({this.refresh = false});
}
