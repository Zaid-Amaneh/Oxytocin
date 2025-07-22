import 'package:flutter/material.dart';
import 'package:oxytocin/features/home/data/model/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(doctor.imageUrl),
                radius: 32,
              ),
              Spacer(),
              Icon(Icons.favorite_border, color: Colors.white),
            ],
          ),
          SizedBox(height: 12),
          Text(doctor.name, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(doctor.specialty, style: TextStyle(color: Colors.white70)),
          SizedBox(height: 8),
          Text('العيادة: ${doctor.clinic}', style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text('يبعد عنك ${doctor.distance} كم', style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text('أقرب موعد: ${doctor.nextAvailableTime}', style: TextStyle(color: Colors.white70, fontSize: 12)),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    SizedBox(width: 4),
                    Text('${doctor.rating} / 5', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(' (بناءً على ${doctor.reviewsCount} تقييمات)', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {},
                icon: Icon(Icons.calendar_today, size: 16),
                label: Text('احجز الآن'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}