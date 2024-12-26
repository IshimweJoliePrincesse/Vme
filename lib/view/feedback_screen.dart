import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:electa/components/button.dart';
import 'package:electa/components/custom_app_bar.dart';
import 'package:electa/components/label_input_field.dart';
import 'package:electa/components/snack.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/view_model/feedback_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key, required this.id});

  final id;

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen>{
  TextEditingController feedbackController = TextEditingController();

  double rating = 0;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override

  Widget build (BuildContext context){
    final feedbackProvider = Provider.of<FeedbackProvider>(context);
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.feedback, context: context, leading: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.ratings, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10),
                Text(AppLocalizationx.of(context)!.rate_your_experience, style: TextStyle(fontSize:16, fontWeight: FontWeight.w500),),
                const SizedBox(height: 5),

                Center(
                  child: RatingBar.builder(
                    initialRating:0,
                    minRating:0,
                    direction:Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal:4.0),
                    itemBuilder: (context, _)=>const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (val){
                      rating = val;
                      setState((){

                      });
                    },
                  ),
                ),

                const SizedBox(height: 5),
                Center(child: Text(AppLocalizations.of(context)!.choose_star, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color:Colors.black45),)),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Text(AppLocalizations.of(context)!.comment, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),

                const SizedBox(height: 10),

                Form(
                  key: _key,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: LabelInputField(label: AppLocalizations.of(context)!.feedback, controller: feedbackController, placeholder:AppLocalizations.of(context)!.enter_feedback, maxLines: 5, validator: (value){
                    if(value!.isEmpty){
                      return AppLocalizations.of(context)!.feedback_required;
                    }
                  },),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 12),
                  child: Button(tap: (){

                    if(feedbackController.text.isEmpty){
                      showSnackBar(context: context, title: 'Feedback Required', color: Colors.red);
                    }
                    else {
                      // feedbackProvider.postFeedback(
                      //   context, rating, feedbackController.text
                      // );

                      feedbackProvider.postFeedback(context: context, ratings: rating, content:feedbackController.text, electionId: widget.id);
                    }
                  }, text: AppLocalizations.of(context)!.submit, color: primaryColor, borderRadius: 10, fontSize: 18,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
