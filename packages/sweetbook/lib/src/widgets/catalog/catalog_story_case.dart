import 'package:agent_flutter/agent_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sweetbook/src/widgets/catalog/catalog.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/sweetbook.dart';

class CatalogStoryCaseWidget extends StatelessWidget {
  final SBStoryCase storyCase;

  const CatalogStoryCaseWidget(this.storyCase);

  Widget buildStoryCase(BuildContext context) {
    final catalogStateAgent = AgentProvider.of<CatalogStateAgent>(context);
    final isSelected =
        catalogStateAgent.state.currentSelectedStoryCase == storyCase;

    return Container(
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : Colors.transparent,
      child: InkWell(
        onTap: () =>
            catalogStateAgent.emit('catalog', StoryCaseTapEvent(storyCase)),
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: catalogElementsVerticalPadding),
          child: Padding(
            padding:
                EdgeInsets.only(left: storyCase.deep * catalogDeepLeftPadding),
            child: Row(
              children: [
                Icon(
                  Icons.icecream,
                  size: 17,
                  color: isSelected
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 10),
                Text(storyCase.name),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildStoryCase(context);
  }
}
