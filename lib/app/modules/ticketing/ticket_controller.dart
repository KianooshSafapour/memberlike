import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memberlike/app/api/api.dart';
import 'package:memberlike/app/models/request/message_request.dart';
import 'package:memberlike/app/models/request/ticket_request.dart';
import 'package:memberlike/app/models/response/ticket_chat_response.dart';
import 'package:memberlike/app/models/response/ticket_list_response.dart';
import 'package:memberlike/shared/widgets/custom_snackbar_widget.dart';

class TicketController extends GetxController {
  TicketController({required this.apiRepository});
  ApiRepository apiRepository;
  final box = GetStorage();
  RxList<TicketListItem> tickets = <TicketListItem>[].obs;
  RxList<TicketChatResponse> messages = <TicketChatResponse>[].obs;
  TextEditingController desctiptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  Rxn<TicketListItem> selectedTicket = Rxn<TicketListItem>();
  RxBool isSending = false.obs;
  Timer? timer;
  Future getTickets() async {
    final userId = await box.read("userId");
    final res = await apiRepository.getTickets(userId.toString());

    if (res != null) {
      tickets.clear();
      for (var i = 0; i < res.data.length; i++) {
        tickets.add(TicketListItem.fromJson(res.data[i]));
      }
      tickets.value = tickets.reversed.toList();
    } else {
      timer?.cancel();
      //show snack bar
      tickets.value = [];
      showDarkSnackbar("error".tr, "noInternetError".tr);
    }
  }

  bool validateCreateTicket() {
    if (titleController.text == '') {
      return false;
    }
    if (desctiptionController.text == '') {
      return false;
    }
    return true;
  }

  Future<String?> createTicket() async {
    if (validateCreateTicket()) {
      final userId = await box.read("userId");
      TicketRequest ticketRequest = TicketRequest(
        ids: "ticket",
        status: "open",
        created: DateTime.now().toString(),
        description: desctiptionController.text,
        subject: titleController.text,
        uid: userId,
      );
      final res = await apiRepository.createTicket(ticketRequest.toJson());
      if (res != null) {
        //refresh or add new ticket to list
        await getTickets();
        desctiptionController.clear();
        titleController.clear();
        return res.data['id'];
      } else {
        return null;
      }
    } else {
      showDarkSnackbar("error".tr, "fillValues".tr);
      return null;
    }
  }

  Future<bool> getMessages() async {
    final res = await apiRepository.getChats(
      selectedTicket.value!.id.toString(),
    );
    if (res != null) {
      for (int i = 0; i < res.data.length; i++) {
        // check is messages contain the message id
        // if not then add it
        // if it does then don't add it

        if (messages.any(
          (element) => element.id == int.parse(res.data[i]["id"].toString()),
        )) {
        } else {
          messages.add(TicketChatResponse.fromJson(res.data[i]));
        }
      }
      return true;
    } else {
      messages.clear();
      showDarkSnackbar("error".tr, "noInternetError".tr);
      return false;
    }
  }

  Future sendMessage() async {
    if (messageController.text.trim() != "") {
      isSending(true);
      final userId = await box.read("userId");
      MessageRequest messageRequest = MessageRequest(
        ids: DateTime.now().hour.milliseconds.toString(),
        author: "user".tr,
        created: DateTime.now().toString(),
        message: messageController.text,
        ticket_id: selectedTicket.value!.id,
        uid: userId,
      );
      final res = await apiRepository.sendMessage(messageRequest.toJson());
      if (res != null) {
        messages.add(
          TicketChatResponse(
            id: int.parse(res.data["id"]),
            uid: userId,
            author: "user",
            message: messageController.text,
            support: 0,
            ticket_id: selectedTicket.value!.id,
            created: DateTime.now().toString(),
          ),
        );
        messages.refresh();
        messageController.clear();
        isSending(false);
      } else {
        showDarkSnackbar("error".tr, "noInternetError".tr);
        isSending(false);
      }
    }
    isSending(false);
  }

  Future<bool> sendFirstMessage(String message) async {
    final userId = await box.read("userId");
    MessageRequest messageRequest = MessageRequest(
      author: "user".tr,
      ids: DateTime.now().hour.milliseconds.toString(),
      created: DateTime.now().toString(),
      message: message,
      ticket_id: selectedTicket.value!.id,
      uid: userId,
    );
    final res = await apiRepository.sendMessage(messageRequest.toJson());
    if (res != null) {
      return true;
    } else {
      showDarkSnackbar("error".tr, "noInternetError".tr);
      return false;
    }
  }
}
