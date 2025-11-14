import 'model.dart';
export 'model.dart';

Future<List<Check>> factCheck(String fact) async {
  return [
    Check(
      title: "Source",
      shortDescription: "There are many variations of passages",
      status: Status.verified,
      description:
          'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
    ),
    Check(
      title: "Facts & Arguments",
      shortDescription: "All the Lorem Ipsum generators",
      status: Status.questionable,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
    Check(
      title: "Manipulation",
      shortDescription: "The generated Lorem Ipsum is",
      status: Status.falseInfo,
      description:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. ",
    ),
    Check(
      title: "Logic",
      shortDescription: "Many desktop publishing packages",
      status: Status.questionable,
      description:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.",
    ),
    Check(
      title: "Confidence Level",
      shortDescription: "Aldus PageMaker including versions",
      status: Status.verified,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
  ];
}
