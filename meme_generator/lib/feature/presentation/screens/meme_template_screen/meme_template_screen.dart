import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';
import 'package:meme_generator/feature/presentation/screens/meme_template_screen/meme_template_wm.dart';
import 'package:meme_generator/feature/presentation/widgets/template.dart';

class MemeTemplateScreen extends StatelessWidget {
  const MemeTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MemeTemplateWidget(memeTemplateWMFactory);
  }
}

class MemeTemplateWidget extends ElementaryWidget<IMemeTemplateWM> {
  const MemeTemplateWidget(
    super.wmFactory, {
    super.key,
  });

  @override
  Widget build(IMemeTemplateWM wm) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 235, 250),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          iconSize: 28,
          onPressed: wm.goBack,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_outlined),
            onPressed: wm.goToCreateTemplate,
            iconSize: 36,
            color: Colors.white,
          )
        ],
      ),
      body: StreamBuilder<List<Template>>(
          stream: wm.templatesController,
          builder: (context, snapshot) {
            final templates = snapshot.data;
            if (templates == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: templates.length,
              itemBuilder: (context, index) {
                final template = templates[index];
                final decoration = BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                );

                return GestureDetector(
                  onTap: () => wm.selectTemplate(template),
                  child: TemplateWidget(
                    key: ValueKey('template-${template.id}'),
                    decoration: decoration,
                    template: template,
                    isEditable: false,
                  ),
                );
              },
            );
          }),
    );
  }
}
