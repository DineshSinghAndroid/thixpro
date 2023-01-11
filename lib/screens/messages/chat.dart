import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isMobile) {
          return ChannelListPage(
            onTap: (c) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return StreamChannel(
                      channel: c,
                      child: ChannelPage(
                        onBackPressed: (context) {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pop();
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        }

        return const SplitView();
      },
      breakpoints: const ScreenBreakpoints(
        desktop: 550,
        tablet: 550,
        watch: 300,
      ),
    );
  }
}

class SplitView extends StatefulWidget {
  const SplitView({
    super.key,
  });

  @override
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  Channel? selectedChannel;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          child: ChannelListPage(
            onTap: (channel) {
              setState(() {
                selectedChannel = channel;
              });
            },
            selectedChannel: selectedChannel,
          ),
        ),
        Flexible(
          flex: 2,
          child: ClipPath(
            child: Scaffold(
              body: selectedChannel != null
                  ? StreamChannel(
                      key: ValueKey(selectedChannel!.cid),
                      channel: selectedChannel!,
                      child: const ChannelPage(showBackButton: false),
                    )
                  : Center(
                      child: Text(
                        'Pick a channel to show the messages 💬',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({
    super.key,
    this.onTap,
    this.selectedChannel,
  });

  final void Function(Channel)? onTap;
  final Channel? selectedChannel;

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    sort: const [SortOption('last_message_at')],
    limit: 20,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamChannelListView(
          onChannelTap: widget.onTap,
          controller: _listController,
          itemBuilder: (context, channels, index, defaultWidget) {
            return defaultWidget.copyWith(
              selected: channels[index] == widget.selectedChannel,
            );
          },
        ),
      );
}

class ChannelPage extends StatefulWidget {
  const ChannelPage({
    super.key,
    this.showBackButton = true,
    this.onBackPressed,
  });

  final bool showBackButton;
  final void Function(BuildContext)? onBackPressed;

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  late final messageInputController = StreamMessageInputController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: StreamChannelHeader(
              onBackPressed: widget.onBackPressed != null
                  ? () {
                      widget.onBackPressed!(context);
                    }
                  : null,
              showBackButton: widget.showBackButton,
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: StreamMessageListView(
                    onMessageSwiped:
                        (CurrentPlatform.isAndroid || CurrentPlatform.isIos)
                            ? reply
                            : null,
                    threadBuilder: (context, parent) {
                      return ThreadPage(
                        parent: parent!,
                      );
                    },
                    messageBuilder:
                        (context, details, messages, defaultWidget) {
                      return defaultWidget.copyWith(
                        onReplyTap: reply,
                      );
                    },
                  ),
                ),
                StreamMessageInput(
                  onQuotedMessageCleared:
                      messageInputController.clearQuotedMessage,
                  focusNode: focusNode,
                  messageInputController: messageInputController,
                ),
              ],
            ),
          ),
        ),
      );

  void reply(Message message) {
    messageInputController.quotedMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}

class ThreadPage extends StatelessWidget {
  const ThreadPage({
    super.key,
    required this.parent,
  });

  final Message parent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamThreadHeader(
        parent: parent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamMessageListView(
              parentMessage: parent,
            ),
          ),
          StreamMessageInput(
            messageInputController: StreamMessageInputController(
              message: Message(parentId: parent.id),
            ),
          ),
        ],
      ),
    );
  }
}
