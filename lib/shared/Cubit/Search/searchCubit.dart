import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/shopmodel/Search.dart';
import 'package:learning/shared/Cubit/Search/SearchStates.dart';
import 'package:learning/shared/compnents/constants.dart';
import 'package:learning/layout/end_point.dart';
import 'package:learning/shared/networking/remote/DioHelper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void postSearch(String text)
  {
    emit(Loading());
    DioHelper.postData(
        url: SEARCH_PRODUCT,
        Token: Token,
        data: {
          'text': text
        }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print('ppppppppppppppp ${searchModel.status}');
      print('ppppppppppppppp ${searchModel.data}');
      emit(Success());
    }).catchError((onError){
      print(onError.toString());
      emit(Error());
    });
  }
}