class Group {
  String gid;
  String groupName;
  String adminUid;
  String groupImageUrl;
  List members;
  List requestingMembers;
  List posts;
  Group(
      {required this.gid,
      required this.groupName,
      required this.adminUid,
      this.groupImageUrl =
          'https://imgs.search.brave.com/65oFsI1cszj1f8cliOT7XOz82gZrC8_J5tjiTZkiRLA/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA0LzYyLzkzLzY2/LzM2MF9GXzQ2Mjkz/NjY4OV9CcEVFY3hm/Z011WVBmVGFJQU9D/MXRDRHVybXNubzdT/cC5qcGc',
      required this.members,
      required this.requestingMembers,
      required this.posts});

  Map<String, dynamic> toJson() {
    return {
      'gid': gid,
      'groupName': groupName,
      'adminUid': adminUid,
      'groupImageUrl': groupImageUrl,
      'members': members,
      'requestingMembers': requestingMembers,
      'posts': posts,
    };
  }
}
