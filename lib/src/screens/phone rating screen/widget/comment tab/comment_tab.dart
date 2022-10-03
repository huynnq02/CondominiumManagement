// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/src/providers/filter_comment_provider.dart';
import 'package:untitled/src/providers/paginator_provider.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/comment.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/filter_bar.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/comment_paginator.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/custom_pie_chart.dart';

class CommentTab extends StatefulWidget {
  Phone phone;

  CommentTab({Key? key, required this.phone}) : super(key: key);
  @override
  State<CommentTab> createState() => _CommentTabState();
}

class _CommentTabState extends State<CommentTab> {
  late PaginatorProvider provider;
  late FilterCommentProvider providerFilter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<PaginatorProvider>(context, listen: true);
    providerFilter = Provider.of<FilterCommentProvider>(context, listen: true);
    providerFilter.filterComment(widget.phone.review);

    return Column(
      children: [
        CustomPieChart(
          phone: widget.phone,
        ),
        SizedBox(
          height: 32,
        ),
        FilterBar(
          idProduct: widget.phone.id.toString(),
          listReview: widget.phone.review!,
        ),
        FutureBuilder(
            future: provider.fetchReview(providerFilter.listComment),
            builder: ((context, snapshot) {
              provider.state > provider.listReview.length
                  ? provider.state = 1
                  : provider.state;
              return Column(
                children: [
                  ChangeNotifierProvider.value(
                      value: providerFilter,
                      child: Comment(
                          review: provider.listReview[provider.state - 1],
                          length: providerFilter
                              .filterComment(widget.phone.review)
                              .length,
                          date: widget.phone.datePreproc.toString())),
                  CommentPaginator(provider.state, provider.listReview.length),
                ],
              );
            })),
      ],
    );
  }
}
