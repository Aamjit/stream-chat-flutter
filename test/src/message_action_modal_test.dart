import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stream_chat_flutter/src/message_actions_modal.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'mocks.dart';

void main() {
  testWidgets(
    'it should show the all actions',
    (WidgetTester tester) async {
      final client = MockClient();
      final clientState = MockClientState();

      when(client.state).thenReturn(clientState);
      when(clientState.user).thenReturn(OwnUser(id: 'user-id'));

      final themeData = ThemeData();
      final streamTheme = StreamChatThemeData.getDefaultTheme(themeData);
      await tester.pumpWidget(
        MaterialApp(
          theme: themeData,
          home: StreamChat(
            streamChatThemeData: streamTheme,
            client: client,
            child: Container(
              child: MessageActionsModal(
                message: Message(
                  text: 'test',
                  user: User(
                    id: 'user-id',
                  ),
                ),
                messageTheme: streamTheme.ownMessageTheme,
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byKey(Key('MessageWidget')), findsOneWidget);
      expect(find.byIcon(StreamIcons.sorting_up), findsOneWidget);
      expect(find.byIcon(StreamIcons.edit), findsOneWidget);
      expect(find.byIcon(StreamIcons.delete), findsOneWidget);
      expect(find.byIcon(StreamIcons.copy), findsOneWidget);
    },
  );
  testWidgets(
    'it should show some actions',
    (WidgetTester tester) async {
      final client = MockClient();
      final clientState = MockClientState();

      when(client.state).thenReturn(clientState);
      when(clientState.user).thenReturn(OwnUser(id: 'user-id'));

      final themeData = ThemeData();
      final streamTheme = StreamChatThemeData.getDefaultTheme(themeData);
      await tester.pumpWidget(
        MaterialApp(
          theme: themeData,
          home: StreamChat(
            streamChatThemeData: streamTheme,
            client: client,
            child: Container(
              child: MessageActionsModal(
                showEditMessage: false,
                showCopyMessage: false,
                showDeleteMessage: false,
                showReply: false,
                message: Message(
                  text: 'test',
                  user: User(
                    id: 'user-id',
                  ),
                ),
                messageTheme: streamTheme.ownMessageTheme,
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byKey(Key('MessageWidget')), findsOneWidget);
      expect(find.byIcon(StreamIcons.sorting_up), findsNothing);
      expect(find.byIcon(StreamIcons.edit), findsNothing);
      expect(find.byIcon(StreamIcons.delete), findsNothing);
      expect(find.byIcon(StreamIcons.copy), findsNothing);
    },
  );
}