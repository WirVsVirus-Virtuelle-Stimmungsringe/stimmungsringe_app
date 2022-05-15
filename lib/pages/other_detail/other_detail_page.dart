import 'package:familiarise/data/message.dart';
import 'package:familiarise/data/other_detail.dart';
import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/other_detail/bloc/other_detail_page_bloc.dart';
import 'package:familiarise/pages/other_detail/bloc/other_detail_page_event.dart';
import 'package:familiarise/pages/other_detail/bloc/other_detail_page_state.dart';
import 'package:familiarise/repositories/dashboard_repository.dart';
import 'package:familiarise/repositories/message_repository.dart';
import 'package:familiarise/widgets/avatar_row_other.dart';
import 'package:familiarise/widgets/avatar_widget_factory.dart';
import 'package:familiarise/widgets/loading_spinner.dart';
import 'package:familiarise/widgets/push_message_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OtherDetailPage extends StatelessWidget {
  static const String routeUri = '/other-detail-page';

  static MapEntry<String, WidgetBuilder> makeRoute() => MapEntry(
        routeUri,
        (BuildContext context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>?;
          final dashboardBloc = args!['dashboardBloc'] as DashboardBloc;
          final otherUserId = args['otherUserId'] as String;

          return BlocProvider.value(
            value: dashboardBloc,
            child: BlocProvider<OtherDetailPageBloc>(
              create: (context) => OtherDetailPageBloc(
                dashboardRepository: DashboardRepository(),
                messageRepository: MessageRepository(),
              ),
              child: OtherDetailPage(
                otherUserId: otherUserId,
              ),
            ),
          );
        },
      );

  const OtherDetailPage({required this.otherUserId, Key? key})
      : super(key: key);

  final String otherUserId;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OtherDetailPageBloc>(context)
        .add(FetchOtherDetailPage(otherUserId));

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Wie geht es eigentlich ... '),
      ),
      child: SafeArea(
        bottom: false,
        child: BlocBuilder<OtherDetailPageBloc, OtherDetailPageState>(
          builder: (context, state) {
            if (state is OtherDetailPageLoaded) {
              return _buildContent();
            } else {
              return LoadingSpinner();
            }
          },
        ),
      ),
    );
  }

  Column _buildContent() {
    return Column(
      children: <Widget>[
        BlocBuilder<OtherDetailPageBloc, OtherDetailPageState>(
          builder: (context, state) {
            if (state is OtherDetailPageLoaded) {
              return AvatarRowOther(
                name: state.otherDetail.user.hasName
                    ? state.otherDetail.user.displayName!
                    : '',
                avatarWidgetFactory: makeAvatarSvgWidgetFactory(
                  userId: state.otherDetail.user.userId,
                  avatarSvgUrl: state.otherDetail.user.avatarSvgUrl,
                ),
                avatarSentiment: state.otherDetail.sentiment,
                sentimentText: state.otherDetail.sentimentText,
              );
            } else {
              return LoadingSpinner();
            }
          },
        ),
        Expanded(
          child: BlocBuilder<OtherDetailPageBloc, OtherDetailPageState>(
            builder: (context, state) {
              if (state is OtherDetailPageLoaded) {
                String? sendingMessage;
                if (state is OtherDetailPageSendingMessage) {
                  sendingMessage = state.sendingForMessage;
                }
                return _buildPushMessageList(
                  state.otherDetail,
                  state.availableMessages,
                  sendingMessage,
                );
              }

              return Container();
            },
          ),
        )
      ],
    );
  }

  ListView _buildPushMessageList(
    OtherDetail otherUserDetails,
    AvailableMessages availableMessages,
    String? sendingMessage,
  ) {
    return ListView.builder(
      itemCount: availableMessages.messageTemplates.length,
      itemBuilder: (context, index) {
        final MessageTemplate messageTemplate =
            availableMessages.messageTemplates[index];

        return _buildPushMessageRow(
          context,
          otherUserDetails,
          messageTemplate,
          isSendingMessage: messageTemplate.text == sendingMessage,
          isLastItem: index < availableMessages.messageTemplates.length - 1,
        );
      },
    );
  }

  Widget _buildPushMessageRow(
    BuildContext context,
    OtherDetail otherUserDetails,
    MessageTemplate messageTemplate, {
    required bool isSendingMessage,
    required bool isLastItem,
  }) {
    final Widget row = Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: PushMessageIcon(),
          ),
          Expanded(
            child:
                _buildMessageText(context, messageTemplate, otherUserDetails),
          ),
          GestureDetector(
            onTap: () {
              if (messageTemplate.used) {
                return;
              }

              BlocProvider.of<OtherDetailPageBloc>(context).add(
                SendMessage(otherUserDetails.user.userId, messageTemplate.text),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: isSendingMessage
                  ? const CupertinoActivityIndicator(
                      radius: 18,
                    )
                  : Icon(
                      FontAwesomeIcons.solidPaperPlane,
                      color: messageTemplate.used
                          ? CupertinoColors.inactiveGray
                          : CupertinoColors.activeBlue,
                      size: 35,
                    ),
            ),
          )
        ],
      ),
    );

    if (!isLastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 60,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: const Color(0xFFD9D9D9),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageText(
    BuildContext context,
    MessageTemplate messageTemplate,
    OtherDetail otherUserDetails,
  ) {
    final messageText = Text(messageTemplate.text);

    if (messageTemplate.used) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          messageText,
          _buildMessageUsedText(context, otherUserDetails)
        ],
      );
    } else {
      return messageText;
    }
  }

  Widget _buildMessageUsedText(
    BuildContext context,
    OtherDetail otherUserDetails,
  ) {
    final bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Color textColor = isDarkTheme
        ? CupertinoColors.inactiveGray
        : CupertinoColors.secondaryLabel;

    return RichText(
      text: TextSpan(
        text: 'Nachricht für den Status',
        style: TextStyle(
          color: textColor,
          fontSize: 12,
        ),
        children: <InlineSpan>[
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: FaIcon(
                otherUserDetails.sentiment.icon,
                size: 12,
                color: textColor,
              ),
            ),
          ),
          const TextSpan(
            text: 'versendet.',
          )
        ],
      ),
    );
  }
}
