#!/usr/bin/env python3
import rclpy
from rclpy.node import Node
from std_msgs.msg import Header
from signal_arm_msgs.msg import GripperPositionControl

class GripperPublisher(Node):
    def __init__(self):
        super().__init__('gripper_publisher')
        self.pub = self.create_publisher(GripperPositionControl, '/gripper_position_control_host', 10)
        self.timer = self.create_timer(0.5, self.publish_gripper_position)

        self.gripper_stroke = 0.0
        self.increment = 10.0
        self.max_stroke = 100.0
        self.min_stroke = 0.0

    def publish_gripper_position(self):
        msg = GripperPositionControl()
        msg.header = Header()
        msg.header.stamp = self.get_clock().now().to_msg()
        msg.gripper_stroke = self.gripper_stroke

        self.get_logger().info(f'Publishing gripper_stroke: {self.gripper_stroke}')
        self.pub.publish(msg)

        # Update the gripper_stroke value
        self.gripper_stroke += self.increment
        if self.gripper_stroke > self.max_stroke or self.gripper_stroke < self.min_stroke:
            self.increment = -self.increment  # Reverse the direction

def main(args=None):
    rclpy.init(args=args)
    gripper_publisher = GripperPublisher()
    rclpy.spin(gripper_publisher)

    gripper_publisher.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
