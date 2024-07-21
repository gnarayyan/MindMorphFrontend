import '../../models/certificate_on_courses.dart';
import '../providers/certificate_eligibility_provider.dart';

class CertificateRepository {
  static Future<List<CertificateListModel>> getEligibleCourses() async {
    final response = await CertificateProvider.getEligibleCourses();
    return CertificateListModel.fromResponseBody(response.body);
  }
}
