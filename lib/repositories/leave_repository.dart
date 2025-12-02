import 'package:flutter/material.dart';


// ---------------------------------------------------------------------------
// MODEL DATA
// ---------------------------------------------------------------------------

class LeaveItem {
  final String id;
  final String type;
  final String dateRange;
  final int days;
  final String status;
  final String? rejectionNote;

  LeaveItem({
    required this.id,
    required this.type,
    required this.dateRange,
    required this.days,
    required this.status,
    this.rejectionNote,
  });
}


// ---------------------------------------------------------------------------
// DATA CONTOH
// ---------------------------------------------------------------------------

final List<LeaveItem> leaveHistoryData = [
  LeaveItem(
    id: '1',
    type: 'Cuti Tahunan',
    dateRange: '20/05/2025 - 22/05/2025',
    days: 3,
    status: 'Waiting',
  ),
  LeaveItem(
    id: '2',
    type: 'Cuti Sakit',
    dateRange: '15/04/2025',
    days: 1,
    status: 'Approved',
  ),
  LeaveItem(
    id: '3',
    type: 'Cuti Tahunan',
    dateRange: '10/01/2025 - 12/01/2025',
    days: 3,
    status: 'Rejected',
    rejectionNote: 'Kekurangan staf.',
  ),
  LeaveItem(
    id: '4',
    type: 'Cuti Melahirkan',
    dateRange: '01/08/2025 - 01/10/2025',
    days: 60,
    status: 'Approved',
  ),
];


// ---------------------------------------------------------------------------
// KARTU RIWAYAT CUTI
// ---------------------------------------------------------------------------

class LeaveItemCard extends StatelessWidget {
  final LeaveItem item;
  final VoidCallback onTap;

  const LeaveItemCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  Map<String, dynamic> _getStatusProps(String status) {
    switch (status) {
      case 'Waiting':
        return {
          'text': 'Menunggu Persetujuan',
          'color': Colors.orange.shade700,
        };
      case 'Approved':
        return {
          'text': 'Disetujui',
          'color': Colors.green.shade600,
        };
      case 'Rejected':
        return {
          'text': 'Ditolak',
          'color': Colors.red.shade600,
        };
      default:
        return {
          'text': 'Status Tidak Diketahui',
          'color': Colors.grey.shade600,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusProps = _getStatusProps(item.status);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Info utama
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.type,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item.dateRange} (${item.days} Hari)',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),

              // Status Pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusProps['color'],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  statusProps['text'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),

              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}


// ---------------------------------------------------------------------------
// HALAMAN UTAMA RIWAYAT CUTI
// ---------------------------------------------------------------------------

class LeaveRepositoryScreen extends StatelessWidget {
  const LeaveRepositoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Cuti',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF333333),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              print('Filter tapped');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const LeaveSummaryWidget(),

          Expanded(
            child: leaveHistoryData.isEmpty
                ? const Center(
              child: Text('Belum ada riwayat cuti.'),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: leaveHistoryData.length,
              itemBuilder: (context, index) {
                final item = leaveHistoryData[index];
                return LeaveItemCard(
                  item: item,
                  onTap: () => _showLeaveDetail(context, item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showLeaveDetail(BuildContext context, LeaveItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Cuti: ${item.type}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(height: 20),

                _buildDetailRow('Tanggal:', item.dateRange),
                _buildDetailRow('Jumlah Hari:', '${item.days} Hari'),
                _buildDetailRow(
                  'Status:',
                  _getStatusProps(item.status)['text'],
                ),

                if (item.rejectionNote != null)
                  _buildDetailRow(
                    'Catatan Penolakan:',
                    item.rejectionNote!,
                  ),

                const SizedBox(height: 20),

                if (item.status == 'Waiting')
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cuti dibatalkan.'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    child: const Text(
                      'Batalkan Pengajuan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic> _getStatusProps(String status) {
    switch (status) {
      case 'Waiting':
        return {
          'text': 'Menunggu Persetujuan',
          'color': Colors.orange.shade700,
        };
      case 'Approved':
        return {
          'text': 'Disetujui',
          'color': Colors.green.shade600,
        };
      case 'Rejected':
        return {
          'text': 'Ditolak',
          'color': Colors.red.shade600,
        };
      default:
        return {
          'text': 'Status Tidak Diketahui',
          'color': Colors.grey.shade600,
        };
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}


// ---------------------------------------------------------------------------
// WIDGET RINGKASAN CUTI
// ---------------------------------------------------------------------------

class LeaveSummaryWidget extends StatelessWidget {
  const LeaveSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryItem(label: 'Saldo Cuti Tersisa', value: '10 Hari'),
          _SummaryItem(label: 'Cuti Diambil Tahun Ini', value: '5 Hari'),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}
