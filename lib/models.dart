class Blog {
  final String nama;
  final String kota;
  final String id;

  const Blog({
    required this.nama,
    required this.kota,
    required this.id,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(nama: json['nama'], kota: json['kota'], id: json['id']);
  }
}
