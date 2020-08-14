import 'dart:convert';

import 'package:dnmui/models/DonorListScreenModel/NotifyDonorRequest.dart';
import 'package:dnmui/models/DonorListScreenModel/RequestDonorRequest.dart';
import 'package:dnmui/services/DonorListScreenService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DonorListPage extends StatefulWidget {
  final List<Map> donorList;
  final String mailid;

  @override
  DonorListPage({Key key, @required this.donorList, this.mailid})
      : super(key: key);

  @override
  _DonorListPageState createState() => _DonorListPageState(donorList, mailid);
}

class _DonorListPageState extends State<DonorListPage> {
  List<Map> donorList;
  _DonorListPageState(this.donorList, this.mailid);

  TextEditingController messageFieldController = new TextEditingController();
  String message = '';
  String mailid;
  bool toggle = true;
  bool messageSubmitStatus = false;
  List<int> iList = [];
  RequestDonorRequest requestDonorRequest;
  NotifyDonorRequest notifyDonorRequest;
  DonorListScreenService donorListScreenService = new DonorListScreenService();

  @override
  void initState() {
    // TODO: implement initState
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    for (int i = 0; i < donorList.length; i++) {
      iList.add(0);
    }
    super.initState();
  }

  SlidableController slidableController;

  List<_DonorInfo> get items => _getItemsList(donorList);

  List<_DonorInfo> _getItemsList(List<Map> donorList) {
    return List.generate(
      donorList.length,
      (i) => _DonorInfo(
          i + 1,
          donorList[i]['username'].toString(),
          _getSubtitle(i),
          _getAvatarColor(i),
          iList[i] == 0 ? _getNotifyButton(i) : _getPostNotifyButton(i)),
    );
  }

  Widget _getNotifyButton(int i) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        onPressed: () async {
          requestDonorRequest = new RequestDonorRequest();
          requestDonorRequest.donorId = donorList[i]['mailid'];
          requestDonorRequest.message =
              message == '' ? _getRequestBloodMessage() : message;
          requestDonorRequest.recipientId = mailid;
          notifyDonorRequest = new NotifyDonorRequest();
          notifyDonorRequest.mailid = donorList[i]['mailid'];
          Map<String, dynamic> notificationResponsedata =
              await donorListScreenService.notifyDonor(notifyDonorRequest);
          Map<String, dynamic> data =
              await donorListScreenService.addRequestToDb(requestDonorRequest);

          setState(() {
            iList[i] = 1;
            print(iList);
          });
        },
        child: Text("Notify Donor", textAlign: TextAlign.center),
      ),
    );
  }

  Widget _getPostNotifyButton(int i) {
    return Material(
//    elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.greenAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: null,
        child: Text("Notified", textAlign: TextAlign.center),
      ),
    );
  }

  Widget _getHelloUserText(String mailid) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red,
          Colors.orange,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 42.0, vertical: 32.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                      child: Text(
                        "Hello, " + mailid,
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                    Text(
                      "Here, You can Notify Donors",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
  }

  Widget _messageBox() {
    return Container(
        width: double.infinity,
        child: TextField(
          controller: messageFieldController,
          obscureText: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Message",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
  }

  doNothing() {}

  Widget _submitMessageButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(50.0),
            color: Color(0xff01A0C7),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              clipBehavior: Clip.antiAlias,
              // Add This
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                setState(() {
                  messageSubmitStatus = true;
                  message = messageFieldController.text;
                  _donorListPageInfo(context);
                });
              },
              child: Text(
                "Submit Message",
                textAlign: TextAlign.center,
              ),
            )));
  }

  _donorListPageInfo(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Message Submitted",
      desc:
          "Message Submitted Succesfully. When you click on notify now..the respective donor will be recieving a mail and a mobile notification with your message as subject",
      buttons: [
        DialogButton(
          child: Text(
            "Okay!",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Requests"),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: <Widget>[
          Container(
              child: ListView(shrinkWrap: true, children: <Widget>[
            _getHelloUserText(mailid),
            SizedBox(child: _messageBox()),
            SizedBox(width: 10, child: _submitMessageButton()),
            SizedBox(height: 10),
          ])),
          SizedBox(
              height: 500, // fixed height
              child: OrientationBuilder(
                builder: (context, orientation) => _buildList(
                    context,
                    orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _fabColor,
        onPressed: null,
        child: _rotationAnimation == null
            ? Icon(Icons.add)
            : RotationTransition(
                turns: _rotationAnimation,
                child: Icon(Icons.add),
              ),
      ),
    );
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      scrollDirection: direction,
      itemBuilder: (context, index) {
        Axis slidableDirection =
            direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
        var item = items[index];
        if (item.index < 8) {
          return _getSlidableWithLists(context, index, slidableDirection);
        } else {
          return _getSlidableWithDelegates(context, index, slidableDirection);
        }
      },
      itemCount: items.length,
    );
  }

  Future<void> share(int i) async {
    await FlutterShare.share(
        title: 'Donor Near Me',
        text: getRequestBloodMessage(i),
        linkUrl: 'http://donornearme.com/',
        chooserTitle: 'Find a blood donor near you!');
  }

  String getRequestBloodMessage(int i) {
    return "Hello, This is " +
        donorList[i]['username'] +
        ". I need blood (" +
        donorList[i]['bloodgroup'] +
        ") urgently. Please contact number " +
        donorList[i]['phonenumber'];
  }

  Widget _getSlidableWithLists(
      BuildContext context, int index, Axis direction) {
    _DonorInfo item = items[index];
    //int t = index;
    return Slidable(
      key: Key(item.title),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          _showSnackBar(
              context,
              actionType == SlideActionType.primary
                  ? 'Dismiss Archive'
                  : 'Dimiss Delete');
          setState(() {
            items.removeAt(index);
          });
        },
      ),
      actionPane: _getActionPane(item.index),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? VerticalListItem(items[index])
          : HorizontalListItem(items[index]),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => _showSnackBar(context, 'Archive'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () {
            share(index);
          },
        ),
      ],
      secondaryActions: <Widget>[
        Container(
          height: 800,
          color: Colors.green,
          child: Text('a'),
        ),
        IconSlideAction(
          caption: 'More',
          color: Colors.grey.shade200,
          icon: Icons.more_horiz,
          onTap: () => _showSnackBar(context, 'More'),
          closeOnTap: false,
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _showSnackBar(context, 'Delete'),
        ),
      ],
    );
  }

  Widget _getSlidableWithDelegates(
      BuildContext context, int index, Axis direction) {
    _DonorInfo item = items[index];

    return Slidable.builder(
      key: Key(item.title),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        closeOnCanceled: true,
        onWillDismiss: (item.index != 10)
            ? null
            : (actionType) {
                return showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Delete'),
                      content: Text('Item will be deleted'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    );
                  },
                );
              },
        onDismissed: (actionType) {
          _showSnackBar(
              context,
              actionType == SlideActionType.primary
                  ? 'Dismiss Archive'
                  : 'Dimiss Delete');
          setState(() {
            items.removeAt(index);
          });
        },
      ),
      actionPane: _getActionPane(item.index),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? VerticalListItem(items[index])
          : HorizontalListItem(items[index]),
      actionDelegate: SlideActionBuilderDelegate(
          actionCount: 2,
          builder: (context, index, animation, renderingMode) {
            if (index == 0) {
              return IconSlideAction(
                caption: 'Archive',
                color: renderingMode == SlidableRenderingMode.slide
                    ? Colors.blue.withOpacity(animation.value)
                    : (renderingMode == SlidableRenderingMode.dismiss
                        ? Colors.blue
                        : Colors.green),
                icon: Icons.archive,
                onTap: () async {
                  var state = Slidable.of(context);
                  var dismiss = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete'),
                        content: Text('Item will be deleted'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      );
                    },
                  );

                  if (dismiss) {
                    state.dismiss();
                  }
                },
              );
            } else {
              return IconSlideAction(
                caption: 'Share',
                color: renderingMode == SlidableRenderingMode.slide
                    ? Colors.indigo.withOpacity(animation.value)
                    : Colors.indigo,
                icon: Icons.share,
                onTap: () {
                  share(index);
                },
              );
            }
          }),
      secondaryActionDelegate: SlideActionBuilderDelegate(
          actionCount: 2,
          builder: (context, index, animation, renderingMode) {
            if (index == 0) {
              return IconSlideAction(
                caption: 'More',
                color: renderingMode == SlidableRenderingMode.slide
                    ? Colors.grey.shade200.withOpacity(animation.value)
                    : Colors.grey.shade200,
                icon: Icons.more_horiz,
                onTap: () => _showSnackBar(context, 'More'),
                closeOnTap: false,
              );
            } else {
              return IconSlideAction(
                caption: 'Delete',
                color: renderingMode == SlidableRenderingMode.slide
                    ? Colors.red.withOpacity(animation.value)
                    : Colors.red,
                icon: Icons.delete,
                onTap: () => _showSnackBar(context, 'Delete'),
              );
            }
          }),
    );
  }

  Widget _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }

  Color _getAvatarColor(int index) {
    switch (index % 4) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.indigoAccent;
      default:
        return null;
    }
  }

  String _getSubtitle(int index) {
    return donorList[index]['town'].toString();
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  String _getRequestBloodMessage() {
    return "Hi, need blood immediatly..";
  }

  printIndex(int i) {
    print(i);
  }

  List<int> getIndexList(List<Map> donorList) {
    List<int> indexList = [];
    for (int i = 0; i < donorList.length; i++) {
      indexList.add(0);
    }
  }
}

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item);

  _DonorInfo item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
              ? Slidable.of(context)?.open()
              : Slidable.of(context)?.close(),
      child: Container(
        color: Colors.white,
        child: ListView(shrinkWrap: true, children: <Widget>[
          Container(
              child: ListTile(
            leading: CircleAvatar(
              backgroundColor: item.color,
              child: Text('${item.index}'),
              foregroundColor: Colors.white,
            ),
            title: Text(item.title),
            subtitle: Text(item.subtitle),
            trailing: item.widget,
          ))
        ]),
      ),
    );
  }
}

class HorizontalListItem extends StatelessWidget {
  HorizontalListItem(this.item);

  _DonorInfo item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 160.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              backgroundColor: item.color,
              child: Text('${item.index}'),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DonorInfo {
  _DonorInfo(this.index, this.title, this.subtitle, this.color, this.widget);

  int index;
  String title;
  String subtitle;
  Color color;
  Widget widget;
}
